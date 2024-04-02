struct Neuron {
    u16 NameLen;
    char Name[NameLen];
    u8 SnoothFunc;
    u32 nWeights;
    float Weights[nWeights];
};

struct Layer {
    u32 nNeurons;
    Neuron Neurons[nNeurons];
};

struct TronFile {
    u8 fmtver;
    bool bContinuous;
    bool bActiveOnly;
    bool bSquare;
    bool bCenter;
    Layer InputLayer;
    Layer OutputLayer;
    u32 nHidden;
    Layer HiddenLayers[nHidden];
};

TronFile tron @ 0x0;