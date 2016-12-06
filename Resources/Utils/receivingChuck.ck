//Configuring IP and Port
OscIn oin;
if(me.args()) me.arg(0) => Std.atoi => oin.port;
else 7000 => oin.port;
oin.listenAll();

//Defining object for handling messages
OscMsg msg;


//Loop through messages
while(true)
{
    oin => now;
    
    while(oin.recv(msg))
    {
        chout <= msg.address <= " ";

        int valores[msg.numArgs()];

        for(int n; n < msg.numArgs(); n++)
        {
            if(msg.typetag.charAt(n) == 'i'){
                chout <= msg.getInt(n) <= " ";
                msg.getInt(n) => valores[n];
            }
        }
        
        chout <= IO.nl();  
        
        for(int n; n < msg.numArgs(); n++){
            <<<valores[n]>>>;
        }             
               
    }
}
