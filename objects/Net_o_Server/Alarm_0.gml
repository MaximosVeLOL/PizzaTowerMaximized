packet.Reset(0x00);
packet.Write(buffer_u8, DataFlag.RecieveID);
packet.Write(buffer_u8, getLastClient());
packet.Write(buffer_u8, MAX_CLIENTS);
packet.Send(clients[getLastClient()].socket);