object CryptMod: TCryptMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 338
  Width = 380
  object RSAKeyGen: TCodec
    AsymetricKeySizeInBits = 1024
    AdvancedOptions2 = []
    CryptoLibrary = CryptographicLibrary1
    Left = 48
    Top = 24
    StreamCipherId = 'native.RSA'
    BlockCipherId = ''
    ChainId = 'native.CBC'
  end
  object CryptographicLibrary1: TCryptographicLibrary
    Left = 128
    Top = 24
  end
  object Signatory1: TSignatory
    Codec = RSAKeyGen
    Left = 224
    Top = 24
  end
  object Hash1: THash
    CryptoLibrary = CryptographicLibrary1
    Left = 304
    Top = 32
    HashId = 'native.hash.SHA-512/256'
  end
  object AES: TCodec
    AsymetricKeySizeInBits = 1024
    AdvancedOptions2 = []
    CryptoLibrary = CryptographicLibrary1
    Left = 48
    Top = 88
    StreamCipherId = 'native.StreamToBlock'
    BlockCipherId = 'native.AES-256'
    ChainId = 'native.CBC'
  end
  object VerifyCodec: TCodec
    AsymetricKeySizeInBits = 1024
    AdvancedOptions2 = []
    CryptoLibrary = CryptographicLibrary1
    Left = 48
    Top = 168
    StreamCipherId = 'native.RSA'
    BlockCipherId = ''
    ChainId = 'native.CBC'
  end
  object Signatory2: TSignatory
    Codec = VerifyCodec
    Left = 128
    Top = 168
  end
  object RSACrypt: TCodec
    AsymetricKeySizeInBits = 1024
    AdvancedOptions2 = []
    CryptoLibrary = CryptographicLibrary1
    Left = 48
    Top = 240
    StreamCipherId = 'native.RSA'
    BlockCipherId = ''
    ChainId = 'native.CBC'
  end
end
