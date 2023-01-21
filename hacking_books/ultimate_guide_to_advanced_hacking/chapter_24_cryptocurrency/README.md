# Cryptocurrency

For more than a decade cryptocurrency has been a hot topic among cybersecurity. First, the idea of being able to 
make a 'anonymous' payment appealed to many, including criminals. Payment would be made with BitCoin, a virtual 
currency that uses cryptography and a publicly accessible ledger for integrity.

In this chapter I will focus on learning you two skills: making anonymous Bitcoin payments and purchasing Bitcoins 
for storage in a cold-wallet. We will stay away from speculating with cryptocurrency or placing money with a 
centralized exchange. The latter demands to know your true identity, and they use software to determine validity of 
the information and ID you provide. For as much as possible we will rely on open-source software run on our own 
computer to create a locally stored Bitcoin wallet.

Throughout learning these skills I will explain the technical background, but feel free to skip this.

Final note, when I say Bitcoin I mean the plethora of cryptocurrencies that have sprung up. However, the examples 
focus on Bitcoin and Ethereum.

## Making payments with Bitcoin

The first requirement for making a payment with either Bitcoin or Ethereum is to have another party willing to 
accept them. Tto test this we will be making an anonymous Bitcoin payment to Hostinger.com, a web provider that does 
not require people to use their real identification. As such its perfect for hackers. But lets first start with 
creating out own wallet. We will use Electrum for this.

1. Download your package of choice from [electrum.org](https://electrum.org/#download). But for the sake of argument 
   choose the 'Standalone Executable' for the Windows OS family.
2. Start the installation guide, initially choose the default options. The location of the wallet does not matter as 
   you can always copy it to another location, so electrum/ will do fine. However, you will eventually recieve the 
   wallet seed. This is an important 'code' for the recovery of your wallet. Note the clear instructions provided. 
   You have to write it down accurately on a piece of paper. Do NOT store it in a password manager.

Here is an example of such a mnemonic pass that acts as an Electrum seed: "peasant, wheelbarrow, motorcar, planet, 
water, ball, seduction, inbreathiate, much, passable, test, opinion"

The order in which you write it down will matter. And yes, I did just write down an Electrum seed as a prank.

3. Finally, you will be asked to create a password to encrypt your wallet. Choose a password that has a minimal 
   length of 12 chars, with at least one Uppercase, lowercase, digit and special symbol. I think you know the drill, 
   store this password somewhere safe such as your favorite password manager.
4. You are now all set, you can close the application if you want. Then copy the wallet to a more secure location. 
   Afterwards.

The next step is to actually obtain some Bitcoins to perform an actual payment. There are online vendors, but of 
course they come with privacy strings attached. Their data could be subpoenaed, that said it is one extra layer of 
distance removed.

Secondly, you could use a Bitcoin ATM. Many cities will have them in cornerstones. There are a number of different 
version and most do not provide full anonymity even if they accept cash. 

Third, is to have a source of Bitcoin income. This is arguably hard as you're just starting out but if people pay you 
for services or goods in Bitcoin then you can immediately reuse them.

Finally, is to purchase Bitcoin with cash. This can usually be done at a Bitcoin-themed conference with buyers and 
sellers in attendance. However, ensure a trusted mediator is present.

### Purchasing Bitcoin at an ATM

This is how I first purchased Bitcoin, and remains the easiest method. This is a guide to the cryptocurrency 
machines provided by General Bytes, although that information I looked up online. I found a list of Bitcoin machine 
for a city in Europe. There were several types. Online most of them listed that ID verification was required. Others 
wanted the buyer to set up an online account beforehand. I decided to forego any kind of account, so ID verification 
it was. This is not my preferred route as there will be a record, but at least no banks are involved.

I found my ATM at the back of a 24hr convenience store. Approaching the machine I tapped the screen to get past the 
welcome message. Then I was asked if I would be making a purchase of up to 10.000 (ten thousand) euros, 
or above that figure. This was my first indication that not everything was as expected. I of course chose the first 
option. Beforehand I was told that ID would have to be scanned as one of the first tasks, but this may only be 
necessary if you go above the purchase threshold. I will tap that option next time as a test.

Next, I was asked if I could present a bitcoin wallet address. Of course, I couldn't, I hadn't installed anything on my 
smartphone. I had only installed Electrum on my laptop, from which I planned to manage my (cold) wallet. However, 
the ATM menu took this into account and allowed me to scan a QR code from which I could install an app from the 
Google app store. There is also an iOS option. I was reluctant to install an app that I had not previously 
investigated, and I also dreaded the possibility of having to fill out an account after all. Luckily, the installation 
went easily and I was presented with a very simple but empty ledger. There is a QR code at the top of the app 
screen which you can enlarge by clicking. The ATM request this QR as a temporary 'wallet', I presented the code and 
the ATM then allowed me to make a purchase. I inserted 50 euros as a trial. After agreeing this was the chosen 
amount I was quickly presented with an update on the ledger of my app. I had purchased Bitcoin for an amount of 50 
euros.

It takes a short while for the transaction to have been verified by the Bitcoin network. More on this later, but 
after making another similar purchase I was the happy owner of a minute amount of Bitcoin. The app even allows you 
to inspect the blockchain in which the transaction was performed. There is not much information to see, which is of 
course what we want. My only regret is that there was no option to print out a paper wallet. After arriving back 
home I decided to transfer the bitcoin purchased to my Electrum wallet.

## Storing Bitcoin in a cold-wallet

Now we have set up a wallet, we may even consider this to be a cold wallet because it is meant as storage, and 
little used. Officially you do not need to keep the wallet itself. This file can be deleted if you want, but is NOT 
encouraged. You can restore your wallet, the private key, from the seed phrase you were asked to make when 
installing Electrum. Using this seed phrase your private key is resurrected as are all the associated transactions.

So lets transfer money, I mean Bitcoin, from the Bitcoin app I installed standing at the Bitcoin ATM to Electrum. This 
is surprisingly easy. To do this you need an address to send the Bitcoin to, for every transaction it is best to 
create a new public address. Electrum allows us to do so. Click on 'receive', enter a description of the transaction 
and the amount you will receive. Note this is just for your own bookkeeping. Electrum will not pull any Bitcoin from 
the app, it can't. Instead, you are shown an URI, address and a lighting. Select address. You should see the 
alphanumeric address, I suppose you do not want to type it over in the app or send it by mail. By clicking on the address itself 
it also transforms into a QR code.

Back in the Bitcoin app choose 'send bitcoin', with the little camera icon capture the QR code from Electrum. Type 
in the amount you want to send. Note the little fee at the bottom. If you are sending all of your bitcoin it should 
be minus the fee. And press send. The Bitcoin will be sent to the Electrum wallet.

In the Electrum wallet you see the transaction pop up after a few seconds. Full confirmation from the mining network 
will have to wait a little longer.
