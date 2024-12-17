// 0x00 : reserved
// 0x04 : reserved
// 0x08 : reserved
// 0x0c : reserved
// 0x10 : Data signal of message
//        bit 31~0 - message[31:0] (Read/Write)
// 0x14 : Data signal of message
//        bit 31~0 - message[63:32] (Read/Write)
// 0x18 : Data signal of message
//        bit 31~0 - message[95:64] (Read/Write)
// 0x1c : Data signal of message
//        bit 31~0 - message[127:96] (Read/Write)
// 0x20 : reserved
// 0x24 : Data signal of num_decoded_signals_i
//        bit 31~0 - num_decoded_signals_i[31:0] (Read/Write)
// 0x28 : reserved
// 0x2c : Data signal of num_decoded_signals_o
//        bit 31~0 - num_decoded_signals_o[31:0] (Read)
// 0x30 : Control signal of num_decoded_signals_o
//        bit 0  - num_decoded_signals_o_ap_vld (Read/COR)
//        others - reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define CONTROL_ADDR_MESSAGE_DATA               0x10
#define CONTROL_BITS_MESSAGE_DATA               128
#define CONTROL_ADDR_NUM_DECODED_SIGNALS_I_DATA 0x24
#define CONTROL_BITS_NUM_DECODED_SIGNALS_I_DATA 32
#define CONTROL_ADDR_NUM_DECODED_SIGNALS_O_DATA 0x2c
#define CONTROL_BITS_NUM_DECODED_SIGNALS_O_DATA 32
#define CONTROL_ADDR_NUM_DECODED_SIGNALS_O_CTRL 0x30
