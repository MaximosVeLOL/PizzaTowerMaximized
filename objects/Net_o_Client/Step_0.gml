if(!hasConnection || ID == 230) return;

packet.Reset(0x00);
packet.Write(buffer_u8, DataFlag.GameData);
packet.Write(buffer_u8, ID);
packet.Write(buffer_u16, o_Player.x);
packet.Write(buffer_u16, o_Player.y);
packet.Write(buffer_u32, o_Player.sprite_index);
packet.Write(buffer_u8, o_Player.image_index);
packet.Write(buffer_s8, o_Player.image_xscale);
packet.Write(buffer_u32, room);
packet.Send(socket);

printCheck();