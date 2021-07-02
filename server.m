listen_addr = '127.0.0.1';
listen_port = int16(8082);
server_cert = 'certificates/server.crt';
server_key = 'certificates/server.key';
client_certs = 'certificates/client.crt';
%
% Run this command once per Matlab-session (in the command window) to
% change to Python3: pyenv('Version','/usr/bin/python3')
% Default is python2

context = py.ssl.SSLContext(py.ssl.PROTOCOL_TLS_SERVER);
context.verify_mode = py.ssl.CERT_REQUIRED;
context.load_cert_chain(server_cert, server_key);
context.load_verify_locations(client_certs);
context.check_hostname = false;

bindsocket = py.socket.socket();

bindsocket.bind({listen_addr, listen_port});
bindsocket.listen(int16(5));

while true
    disp("Waiting for client:");
    value = bindsocket.accept();
    
    newsocket = value{1};
    fromaddr = value{2};
    
    disp("Client connected:" + fromaddr{1} + ":" + num2str(int64(fromaddr{2})));
    
    conn = context.wrap_socket(newsocket, int16(1));
    
    disp("SSL established!");
    
    while true
        data = conn.recv(int16(4096));
        if (data == "")
            break;
        else
            %disp("Data received!");
            %disp(data);
            conn.sendall(data);
        end
    end
    
    disp("Closing connection");
    conn.shutdown(socket.SHUT_RDWR);
    conn.close();
end
