var sessionBuffer = buffer_create(8,buffer_fixed, 1);
//buffer_write(sessionBuffer, buffer_u64, 0x_DE_7F_66_89_AA_7B_D3_44); //Checksum
buffer_write(sessionBuffer, buffer_s32, sessions.total); //This is enough I think?
buffer_write(sessionBuffer, buffer_s32, sessions.save);
buffer_save(sessionBuffer, "MaximizedGM2/SESSION");
buffer_delete(sessionBuffer);