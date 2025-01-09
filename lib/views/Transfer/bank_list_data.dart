import 'package:mra/views/Transfer/model/bankList.dart';

const bankListresponse = '''
    {
        "success": true,
        "message": "Bank list retrieved",
        "data": [
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647868/banks/Mask_Group_6_2x_ajl9qn.png",
            "name": "GTBank",
            "code": "058"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589651227/banks/access_aylbko.png",
            "name": "Access Bank",
            "code": "044"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589651359/banks/diamond-bank-squarelogo_ituugx.png",
            "name": "Diamond (Access) Bank",
            "code": "063"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647868/banks/Mask_Group_11_2x_xfhqln.png",
            "name": "First Bank",
            "code": "011"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647868/banks/Mask_Group_7_2x_g5z8mp.png",
            "name": "United Bank for Africa",
            "code": "033"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647869/banks/Mask_Group_15_2x_aymcr2.png",
            "name": "Zenith Bank",
            "code": "057"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647868/banks/Mask_Group_9_2x_gucqev.png",
            "name": "Union Bank Of Nigeria",
            "code": "032"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647869/banks/Mask_Group_18_2x_uqg1cb.png",
            "name": "Fidelity Bank",
            "code": "070"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647868/banks/Mask_Group_12_2x_ajaaaq.png",
            "name": "FCMB",
            "code": "214"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647869/banks/Mask_Group_17_2x_iyqqax.png",
            "name": "WEMA Bank PLC",
            "code": "035"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647869/banks/Mask_Group_16_2x_lgkqtd.png",
            "name": "EcoBank Nigeria",
            "code": "050"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647869/banks/Mask_Group_8_2x_efbdkq.png",
            "name": "Stanbic IBTC",
            "code": "221"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1592478609/banks/polaris_siuxd3.png",
            "name": "Polaris Bank",
            "code": "076"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589651667/banks/Mask_Group_19_2x_ssehfm.png",
            "name": "Keystone Bank",
            "code": "082"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589651890/banks/Sterling_new_logo_dos4j3.png",
            "name": "Sterling Bank",
            "code": "232"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589651805/banks/Mask_Group_22_2x_brposk.png",
            "name": "Unity Bank",
            "code": "215"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647869/banks/Mask_Group_20_2x_evhzxs.png",
            "name": "Providus Bank",
            "code": "101"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647868/banks/Mask_Group_14_2x_kj3sor.png",
            "name": "Heritage Bank",
            "code": "030"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1592478445/banks/citi_picidj.jpg",
            "name": "CITI Bank",
            "code": "023"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589651438/banks/Mask_Group_21_2x_xx4nrc.png",
            "name": "Standard Chartered",
            "code": "068"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1606712239/banks/OLySnqpQ_400x400_or2wub.png",
            "name": "JAIZ Bank",
            "code": "301"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1609981814/banks/C7ojJSQlm0ae8xRxH7kiET-PxIHSZfk2BQ8-ipu0H7EiUnIcgpgDmHLVfZyIEj7wzxrY_joprhj.png",
            "name": "Kuda Microfinance Bank",
            "code": "50211"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1609981884/banks/1519863307585_kov0x1.png",
            "name": "VFD microfinance Bank",
            "code": "566"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1669813321/banks/premium-trust-bank-logo-1024x284-1_gcaggl.png",
            "name": "Premium Trust Bank",
            "code": "000031"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1609981921/banks/Paycom-Opay_o1kada.jpg",
            "name": "PAYCOM (OPAY)",
            "code": "304"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1609982130/banks/Coronation-Merchant-Bank-logo_rnrn6r.png",
            "name": "Coronation Bank",
            "code": "559"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1645414287/banks/61f3fbaf2784d3631ab5637e_ld8fe0.jpg",
            "name": "THINK finance Microfinance Bank",
            "code": "090373"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1645414243/banks/61fb9dd72784d3dabdb565cc_gx8uxp.jpg",
            "name": "FIDFUND Microfinance Bank",
            "code": "090126"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1645414214/banks/logo_mznltl.png",
            "name": "ACCION Microfinance Bank",
            "code": "602"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1609982193/banks/256x256bb_enuog6.jpg",
            "name": "Rubies Microfinance Bank",
            "code": "125"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1609982250/banks/1584624852966_qjqbwe.jpg",
            "name": "Suntrust Bank Nigeria Limited",
            "code": "100"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1609982288/banks/Taj-1_t3pgck.png",
            "name": "Taj Bank",
            "code": "302"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1610009450/banks/XGltYWdlc1xjb250ZW50XDYxNTIwMTkyNTgwMV90aXRhbnRydXN0YmFua2xvZ28ucG5nfDUwMHwzMDB8_smkjph.jpg",
            "name": "Titan Trust Bank",
            "code": "102"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1612465984/banks/reducedby15px_uj2dh1.png",
            "name": "Grooming Microfinance bank",
            "code": "090195"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1612466067/banks/1519891532116_csvwrh.png",
            "name": "Lapo MFB",
            "code": "090177"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1612466443/banks/rsw2f0qpf2bfx7jullir.jpg",
            "name": "AB Microfinance Bank",
            "code": "090270"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1668885576/banks/271869208_487756379604203_6996538215685000955_n.jpg_pyphcz.jpg",
            "name": "Moniepoint MFB",
            "code": "50515"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1668885481/banks/logo.5ef03e1a_r9ackt.png",
            "name": "Palmpay",
            "code": "100033"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1668885517/banks/NowNow-Logo-1_lywx7n.png",
            "name": "NowNow digital",
            "code": "100032"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1668885543/banks/Globus_20Logo_mh0wyk.png",
            "name": "Globus",
            "code": "000027"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1668885602/banks/Logo_aadlaf.png",
            "name": "Carbon",
            "code": "100026"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1668886449/banks/LOGO_kbukqv.jpg",
            "name": "Fina Trust MFB",
            "code": "090111"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1668886364/banks/lotus-logo2x_g9ubuj.png",
            "name": "Lotus Bank",
            "code": "000029"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1674122023/banks/WhatsApp_Image_2022-09-07_at_3.37.34_PM-removebg-preview_v93jeu.png",
            "name": "Lifegate Microfinance Bank",
            "code": "090557"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1679471144/banks/ALPHA-KAPITAL-LOGO_p3nshv.jpg",
            "name": "AlphaKapital MFB Bank",
            "code": "51222"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1679673691/banks/image_3_o50rm6.png",
            "name": "Excellent MFB Bank",
            "code": "090541"
        },
        {
            "url": "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1679673691/banks/PHOTO-2023-03-24-16-59-59_yayirb.jpg",
            "name": "CORESTEP MICROFINANCE Bank",
            "code": "50204"
        }
    ]
    }
    ''';

List<Datum> banks = [
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647868/banks/Mask_Group_6_2x_ajl9qn.png",
      name: "GTBank",
      code: "058"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589651227/banks/access_aylbko.png",
      name: "Access bank",
      code: "044"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589651359/banks/diamond-bank-squarelogo_ituugx.png",
      name: "Diamond (Access) Bank",
      code: "063"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647868/banks/Mask_Group_11_2x_xfhqln.png",
      name: "First Bank",
      code: "011"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647868/banks/Mask_Group_7_2x_g5z8mp.png",
      name: "United Bank for Africa",
      code: "033"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647869/banks/Mask_Group_15_2x_aymcr2.png",
      name: "Zenith Bank",
      code: "057"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647868/banks/Mask_Group_9_2x_gucqev.png",
      name: "Union Bank Of Nigeria",
      code: "032"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647869/banks/Mask_Group_18_2x_uqg1cb.png",
      name: "Fidelity Bank",
      code: "070"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647868/banks/Mask_Group_12_2x_ajaaaq.png",
      name: "FCMB",
      code: "214"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647869/banks/Mask_Group_17_2x_iyqqax.png",
      name: "WEMA Bank PLC",
      code: "035"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647869/banks/Mask_Group_16_2x_lgkqtd.png",
      name: "EcoBank Nigeria",
      code: "050"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647869/banks/Mask_Group_8_2x_efbdkq.png",
      name: "Stanbic IBTC",
      code: "221"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1592478609/banks/polaris_siuxd3.png",
      name: "Polaris Bank",
      code: "076"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589651667/banks/Mask_Group_19_2x_ssehfm.png",
      name: "Keystone Bank",
      code: "082"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589651890/banks/Sterling_new_logo_dos4j3.png",
      name: "Sterling Bank",
      code: "232"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589651805/banks/Mask_Group_22_2x_brposk.png",
      name: "Unity Bank",
      code: "215"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647869/banks/Mask_Group_20_2x_evhzxs.png",
      name: "Providus Bank",
      code: "101"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589647868/banks/Mask_Group_14_2x_kj3sor.png",
      name: "Heritage Bank",
      code: "030"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1592478445/banks/citi_picidj.jpg",
      name: "CITI Bank",
      code: "023"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1589651438/banks/Mask_Group_21_2x_xx4nrc.png",
      name: "Standard Chartered",
      code: "068"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1606712239/banks/OLySnqpQ_400x400_or2wub.png",
      name: "JAIZ Bank",
      code: "301"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1609981814/banks/C7ojJSQlm0ae8xRxH7kiET-PxIHSZfk2BQ8-ipu0H7EiUnIcgpgDmHLVfZyIEj7wzxrY_joprhj.png",
      name: "Kuda Microfinance Bank",
      code: "50211"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1609981884/banks/1519863307585_kov0x1.png",
      name: "VFD microfinance Bank",
      code: "566"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1669813321/banks/premium-trust-bank-logo-1024x284-1_gcaggl.png",
      name: "Premium Trust Bank",
      code: "000031"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1609981921/banks/Paycom-Opay_o1kada.jpg",
      name: "PAYCOM (OPAY)",
      code: "304"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1609982130/banks/Coronation-Merchant-Bank-logo_rnrn6r.png",
      name: "Coronation Bank",
      code: "559"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1645414287/banks/61f3fbaf2784d3631ab5637e_ld8fe0.jpg",
      name: "THINK finance Microfinance Bank",
      code: "090373"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1645414243/banks/61fb9dd72784d3dabdb565cc_gx8uxp.jpg",
      name: "FIDFUND Microfinance Bank",
      code: "090126"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1645414214/banks/logo_mznltl.png",
      name: "ACCION Microfinance Bank",
      code: "602"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1609982193/banks/256x256bb_enuog6.jpg",
      name: "Rubies Microfinance Bank",
      code: "125"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1609982250/banks/1584624852966_qjqbwe.jpg",
      name: "Suntrust Bank Nigeria Limited",
      code: "100"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1609982288/banks/Taj-1_t3pgck.png",
      name: "Taj Bank",
      code: "302"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1610009450/banks/XGltYWdlc1xjb250ZW50XDYxNTIwMTkyNTgwMV90aXRhbnRydXN0YmFua2xvZ28ucG5nfDUwMHwzMDB8_smkjph.jpg",
      name: "Titan Trust Bank",
      code: "102"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1612465984/banks/reducedby15px_uj2dh1.png",
      name: "Grooming Microfinance bank",
      code: "090195"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1612466067/banks/1519891532116_csvwrh.png",
      name: "Lapo MFB",
      code: "090177"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1612466443/banks/rsw2f0qpf2bfx7jullir.jpg",
      name: "AB Microfinance Bank",
      code: "090270"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1668885576/banks/271869208_487756379604203_6996538215685000955_n.jpg_pyphcz.jpg",
      name: "Moniepoint MFB",
      code: "50515"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1668885481/banks/logo.5ef03e1a_r9ackt.png",
      name: "Palmpay",
      code: "100033"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1668885517/banks/NowNow-Logo-1_lywx7n.png",
      name: "NowNow digital",
      code: "100032"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1668885543/banks/Globus_20Logo_mh0wyk.png",
      name: "Globus",
      code: "000027"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1668885602/banks/Logo_aadlaf.png",
      name: "Carbon",
      code: "100026"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1668886449/banks/LOGO_kbukqv.jpg",
      name: "Fina Trust MFB",
      code: "090111"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1668886364/banks/lotus-logo2x_g9ubuj.png",
      name: "Lotus Bank",
      code: "000029"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1674122023/banks/WhatsApp_Image_2022-09-07_at_3.37.34_PM-removebg-preview_v93jeu.png",
      name: "Lifegate Microfinance Bank",
      code: "090557"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1679471144/banks/ALPHA-KAPITAL-LOGO_p3nshv.jpg",
      name: "AlphaKapital MFB Bank",
      code: "51222"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1679673691/banks/image_3_o50rm6.png",
      name: "Excellent MFB Bank",
      code: "090541"),
  Datum(
      url:
          "https://res.cloudinary.com/dbhhyyqd5/image/upload/v1679673691/banks/PHOTO-2023-03-24-16-59-59_yayirb.jpg",
      name: "CORESTEP MICROFINANCE Bank",
      code: "50204")
];
