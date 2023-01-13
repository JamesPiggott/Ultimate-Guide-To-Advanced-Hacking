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

## Storing Bitcoin in a cold-wallet