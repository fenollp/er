lexer grammar Lexer;


/// Blanks

Comment : '#' (~[\{\r\n] ~[\r\n]*)? '\r'? '\n' -> channel(HIDDEN) ;

WS : [ \t\r\n]+ -> channel(HIDDEN) ;


/// Tokens
    // Add A-Z to the negative match to forbid camelCase

fragment //    ≈ [_a-zA-Z0-9]
ATOM_NOTSPECIALS : ~([ \t\r\n()\[\]{}:;,<>|&/=]        | '\u2264'|'\u2265'|'\u2260'|'\u2248'|'\u2261'|'\u2262' | '\u2190'|'\u21d0'|'\u219c' | '\u00ac'|'\u22c0'|'\u22c1') ; // ≤ ≥ ≠ ≈ ≡ ≢ ← ⇐ ↜ ¬ ⋀ ⋁

fragment //    ≈ [_a-zA-Z0-9]
VAR_NOTSPECIALS :  ~([ \t\r\n()\[\]{}:;,<>|&/=*+-] |'.'| '\u2264'|'\u2265'|'\u2260'|'\u2248'|'\u2261'|'\u2262' | '\u2190'|'\u21d0'|'\u219c' | '\u00ac'|'\u22c0'|'\u22c1') ; // ≤ ≥ ≠ ≈ ≡ ≢ ← ⇐ ↜ ¬ ⋀ ⋁

Atom :  Ll              ATOM_NOTSPECIALS*
     | '$' ATOM_NOTSPECIALS ATOM_NOTSPECIALS+  // = '$' ATOM_NOTSPECIALS{2,}
     | '\'' ( '\\' (~'\\'|'\\') | ~[\\''] )* '\'' ;

Var : (Lu|'_')           VAR_NOTSPECIALS* ;

// When using negative match, be sure to also negative match
//   previously-defined rules.

fragment // Not only groups of 3; matches nums without _; all nums possible.
NUM : ([0-9] '_'?)* [0-9] ;

Float : NUM '.' NUM  ([Ee] [+-]? NUM)? ;

Integer : NUM ('#' (NUM | [0-9a-zA-Z]+))? ;

Char : '$' ('\\'? ~[ \t\r\n] | '\\' [0-9] [0-9] [0-9]) ;

String : '"' ( '\\' (.|'\\') | ~[\\""] )* '"' ;
BString : '\u201c' ( '\\' (.|'\\') | ~('\\'|'\u201d') )* '\u201d' ; // “ ”


/// Unicode stuff -- Letter {low|upp}ercase

fragment // All Unicode characters of the Ll (Letter, lowercase) class
Ll : '\u0061' | '\u0062' | '\u0063' | '\u0064' | '\u0065' | '\u0066' | '\u0067' | '\u0068' | '\u0069' | '\u006a' | '\u006b' | '\u006c' | '\u006d' | '\u006e' | '\u006f' | '\u0070' | '\u0071' | '\u0072' | '\u0073' | '\u0074' | '\u0075' | '\u0076' | '\u0077' | '\u0078' | '\u0079' | '\u007a' | '\u00b5' | '\u00df' | '\u00e0' | '\u00e1' | '\u00e2' | '\u00e3' | '\u00e4' | '\u00e5' | '\u00e6' | '\u00e7' | '\u00e8' | '\u00e9' | '\u00ea' | '\u00eb' | '\u00ec' | '\u00ed' | '\u00ee' | '\u00ef' | '\u00f0' | '\u00f1' | '\u00f2' | '\u00f3' | '\u00f4' | '\u00f5' | '\u00f6' | '\u00f8' | '\u00f9' | '\u00fa' | '\u00fb' | '\u00fc' | '\u00fd' | '\u00fe' | '\u00ff' | '\u0101' | '\u0103' | '\u0105' | '\u0107' | '\u0109' | '\u010b' | '\u010d' | '\u010f' | '\u0111' | '\u0113' | '\u0115' | '\u0117' | '\u0119' | '\u011b' | '\u011d' | '\u011f' | '\u0121' | '\u0123' | '\u0125' | '\u0127' | '\u0129' | '\u012b' | '\u012d' | '\u012f' | '\u0131' | '\u0133' | '\u0135' | '\u0137' | '\u0138' | '\u013a' | '\u013c' | '\u013e' | '\u0140' | '\u0142' | '\u0144' | '\u0146' | '\u0148' | '\u0149' | '\u014b' | '\u014d' | '\u014f' | '\u0151' | '\u0153' | '\u0155' | '\u0157' | '\u0159' | '\u015b' | '\u015d' | '\u015f' | '\u0161' | '\u0163' | '\u0165' | '\u0167' | '\u0169' | '\u016b' | '\u016d' | '\u016f' | '\u0171' | '\u0173' | '\u0175' | '\u0177' | '\u017a' | '\u017c' | '\u017e' | '\u017f' | '\u0180' | '\u0183' | '\u0185' | '\u0188' | '\u018c' | '\u018d' | '\u0192' | '\u0195' | '\u0199' | '\u019a' | '\u019b' | '\u019e' | '\u01a1' | '\u01a3' | '\u01a5' | '\u01a8' | '\u01aa' | '\u01ab' | '\u01ad' | '\u01b0' | '\u01b4' | '\u01b6' | '\u01b9' | '\u01ba' | '\u01bd' | '\u01be' | '\u01bf' | '\u01c6' | '\u01c9' | '\u01cc' | '\u01ce' | '\u01d0' | '\u01d2' | '\u01d4' | '\u01d6' | '\u01d8' | '\u01da' | '\u01dc' | '\u01dd' | '\u01df' | '\u01e1' | '\u01e3' | '\u01e5' | '\u01e7' | '\u01e9' | '\u01eb' | '\u01ed' | '\u01ef' | '\u01f0' | '\u01f3' | '\u01f5' | '\u01f9' | '\u01fb' | '\u01fd' | '\u01ff' | '\u0201' | '\u0203' | '\u0205' | '\u0207' | '\u0209' | '\u020b' | '\u020d' | '\u020f' | '\u0211' | '\u0213' | '\u0215' | '\u0217' | '\u0219' | '\u021b' | '\u021d' | '\u021f' | '\u0221' | '\u0223' | '\u0225' | '\u0227' | '\u0229' | '\u022b' | '\u022d' | '\u022f' | '\u0231' | '\u0233' | '\u0234' | '\u0235' | '\u0236' | '\u0237' | '\u0238' | '\u0239' | '\u023c' | '\u023f' | '\u0240' | '\u0242' | '\u0247' | '\u0249' | '\u024b' | '\u024d' | '\u024f' | '\u0250' | '\u0251' | '\u0252' | '\u0253' | '\u0254' | '\u0255' | '\u0256' | '\u0257' | '\u0258' | '\u0259' | '\u025a' | '\u025b' | '\u025c' | '\u025d' | '\u025e' | '\u025f' | '\u0260' | '\u0261' | '\u0262' | '\u0263' | '\u0264' | '\u0265' | '\u0266' | '\u0267' | '\u0268' | '\u0269' | '\u026a' | '\u026b' | '\u026c' | '\u026d' | '\u026e' | '\u026f' | '\u0270' | '\u0271' | '\u0272' | '\u0273' | '\u0274' | '\u0275' | '\u0276' | '\u0277' | '\u0278' | '\u0279' | '\u027a' | '\u027b' | '\u027c' | '\u027d' | '\u027e' | '\u027f' | '\u0280' | '\u0281' | '\u0282' | '\u0283' | '\u0284' | '\u0285' | '\u0286' | '\u0287' | '\u0288' | '\u0289' | '\u028a' | '\u028b' | '\u028c' | '\u028d' | '\u028e' | '\u028f' | '\u0290' | '\u0291' | '\u0292' | '\u0293' | '\u0295' | '\u0296' | '\u0297' | '\u0298' | '\u0299' | '\u029a' | '\u029b' | '\u029c' | '\u029d' | '\u029e' | '\u029f' | '\u02a0' | '\u02a1' | '\u02a2' | '\u02a3' | '\u02a4' | '\u02a5' | '\u02a6' | '\u02a7' | '\u02a8' | '\u02a9' | '\u02aa' | '\u02ab' | '\u02ac' | '\u02ad' | '\u02ae' | '\u02af' | '\u0371' | '\u0373' | '\u0377' | '\u037b' | '\u037c' | '\u037d' | '\u0390' | '\u03ac' | '\u03ad' | '\u03ae' | '\u03af' | '\u03b0' | '\u03b1' | '\u03b2' | '\u03b3' | '\u03b4' | '\u03b5' | '\u03b6' | '\u03b7' | '\u03b8' | '\u03b9' | '\u03ba' | '\u03bb' | '\u03bc' | '\u03bd' | '\u03be' | '\u03bf' | '\u03c0' | '\u03c1' | '\u03c2' | '\u03c3' | '\u03c4' | '\u03c5' | '\u03c6' | '\u03c7' | '\u03c8' | '\u03c9' | '\u03ca' | '\u03cb' | '\u03cc' | '\u03cd' | '\u03ce' | '\u03d0' | '\u03d1' | '\u03d5' | '\u03d6' | '\u03d7' | '\u03d9' | '\u03db' | '\u03dd' | '\u03df' | '\u03e1' | '\u03e3' | '\u03e5' | '\u03e7' | '\u03e9' | '\u03eb' | '\u03ed' | '\u03ef' | '\u03f0' | '\u03f1' | '\u03f2' | '\u03f3' | '\u03f5' | '\u03f8' | '\u03fb' | '\u03fc' | '\u0430' | '\u0431' | '\u0432' | '\u0433' | '\u0434' | '\u0435' | '\u0436' | '\u0437' | '\u0438' | '\u0439' | '\u043a' | '\u043b' | '\u043c' | '\u043d' | '\u043e' | '\u043f' | '\u0440' | '\u0441' | '\u0442' | '\u0443' | '\u0444' | '\u0445' | '\u0446' | '\u0447' | '\u0448' | '\u0449' | '\u044a' | '\u044b' | '\u044c' | '\u044d' | '\u044e' | '\u044f' | '\u0450' | '\u0451' | '\u0452' | '\u0453' | '\u0454' | '\u0455' | '\u0456' | '\u0457' | '\u0458' | '\u0459' | '\u045a' | '\u045b' | '\u045c' | '\u045d' | '\u045e' | '\u045f' | '\u0461' | '\u0463' | '\u0465' | '\u0467' | '\u0469' | '\u046b' | '\u046d' | '\u046f' | '\u0471' | '\u0473' | '\u0475' | '\u0477' | '\u0479' | '\u047b' | '\u047d' | '\u047f' | '\u0481' | '\u048b' | '\u048d' | '\u048f' | '\u0491' | '\u0493' | '\u0495' | '\u0497' | '\u0499' | '\u049b' | '\u049d' | '\u049f' | '\u04a1' | '\u04a3' | '\u04a5' | '\u04a7' | '\u04a9' | '\u04ab' | '\u04ad' | '\u04af' | '\u04b1' | '\u04b3' | '\u04b5' | '\u04b7' | '\u04b9' | '\u04bb' | '\u04bd' | '\u04bf' | '\u04c2' | '\u04c4' | '\u04c6' | '\u04c8' | '\u04ca' | '\u04cc' | '\u04ce' | '\u04cf' | '\u04d1' | '\u04d3' | '\u04d5' | '\u04d7' | '\u04d9' | '\u04db' | '\u04dd' | '\u04df' | '\u04e1' | '\u04e3' | '\u04e5' | '\u04e7' | '\u04e9' | '\u04eb' | '\u04ed' | '\u04ef' | '\u04f1' | '\u04f3' | '\u04f5' | '\u04f7' | '\u04f9' | '\u04fb' | '\u04fd' | '\u04ff' | '\u0501' | '\u0503' | '\u0505' | '\u0507' | '\u0509' | '\u050b' | '\u050d' | '\u050f' | '\u0511' | '\u0513' | '\u0515' | '\u0517' | '\u0519' | '\u051b' | '\u051d' | '\u051f' | '\u0521' | '\u0523' | '\u0525' | '\u0527' | '\u0561' | '\u0562' | '\u0563' | '\u0564' | '\u0565' | '\u0566' | '\u0567' | '\u0568' | '\u0569' | '\u056a' | '\u056b' | '\u056c' | '\u056d' | '\u056e' | '\u056f' | '\u0570' | '\u0571' | '\u0572' | '\u0573' | '\u0574' | '\u0575' | '\u0576' | '\u0577' | '\u0578' | '\u0579' | '\u057a' | '\u057b' | '\u057c' | '\u057d' | '\u057e' | '\u057f' | '\u0580' | '\u0581' | '\u0582' | '\u0583' | '\u0584' | '\u0585' | '\u0586' | '\u0587' | '\u1d00' | '\u1d01' | '\u1d02' | '\u1d03' | '\u1d04' | '\u1d05' | '\u1d06' | '\u1d07' | '\u1d08' | '\u1d09' | '\u1d0a' | '\u1d0b' | '\u1d0c' | '\u1d0d' | '\u1d0e' | '\u1d0f' | '\u1d10' | '\u1d11' | '\u1d12' | '\u1d13' | '\u1d14' | '\u1d15' | '\u1d16' | '\u1d17' | '\u1d18' | '\u1d19' | '\u1d1a' | '\u1d1b' | '\u1d1c' | '\u1d1d' | '\u1d1e' | '\u1d1f' | '\u1d20' | '\u1d21' | '\u1d22' | '\u1d23' | '\u1d24' | '\u1d25' | '\u1d26' | '\u1d27' | '\u1d28' | '\u1d29' | '\u1d2a' | '\u1d2b' | '\u1d6b' | '\u1d6c' | '\u1d6d' | '\u1d6e' | '\u1d6f' | '\u1d70' | '\u1d71' | '\u1d72' | '\u1d73' | '\u1d74' | '\u1d75' | '\u1d76' | '\u1d77' | '\u1d79' | '\u1d7a' | '\u1d7b' | '\u1d7c' | '\u1d7d' | '\u1d7e' | '\u1d7f' | '\u1d80' | '\u1d81' | '\u1d82' | '\u1d83' | '\u1d84' | '\u1d85' | '\u1d86' | '\u1d87' | '\u1d88' | '\u1d89' | '\u1d8a' | '\u1d8b' | '\u1d8c' | '\u1d8d' | '\u1d8e' | '\u1d8f' | '\u1d90' | '\u1d91' | '\u1d92' | '\u1d93' | '\u1d94' | '\u1d95' | '\u1d96' | '\u1d97' | '\u1d98' | '\u1d99' | '\u1d9a' | '\u1e01' | '\u1e03' | '\u1e05' | '\u1e07' | '\u1e09' | '\u1e0b' | '\u1e0d' | '\u1e0f' | '\u1e11' | '\u1e13' | '\u1e15' | '\u1e17' | '\u1e19' | '\u1e1b' | '\u1e1d' | '\u1e1f' | '\u1e21' | '\u1e23' | '\u1e25' | '\u1e27' | '\u1e29' | '\u1e2b' | '\u1e2d' | '\u1e2f' | '\u1e31' | '\u1e33' | '\u1e35' | '\u1e37' | '\u1e39' | '\u1e3b' | '\u1e3d' | '\u1e3f' | '\u1e41' | '\u1e43' | '\u1e45' | '\u1e47' | '\u1e49' | '\u1e4b' | '\u1e4d' | '\u1e4f' | '\u1e51' | '\u1e53' | '\u1e55' | '\u1e57' | '\u1e59' | '\u1e5b' | '\u1e5d' | '\u1e5f' | '\u1e61' | '\u1e63' | '\u1e65' | '\u1e67' | '\u1e69' | '\u1e6b' | '\u1e6d' | '\u1e6f' | '\u1e71' | '\u1e73' | '\u1e75' | '\u1e77' | '\u1e79' | '\u1e7b' | '\u1e7d' | '\u1e7f' | '\u1e81' | '\u1e83' | '\u1e85' | '\u1e87' | '\u1e89' | '\u1e8b' | '\u1e8d' | '\u1e8f' | '\u1e91' | '\u1e93' | '\u1e95' | '\u1e96' | '\u1e97' | '\u1e98' | '\u1e99' | '\u1e9a' | '\u1e9b' | '\u1e9c' | '\u1e9d' | '\u1e9f' | '\u1ea1' | '\u1ea3' | '\u1ea5' | '\u1ea7' | '\u1ea9' | '\u1eab' | '\u1ead' | '\u1eaf' | '\u1eb1' | '\u1eb3' | '\u1eb5' | '\u1eb7' | '\u1eb9' | '\u1ebb' | '\u1ebd' | '\u1ebf' | '\u1ec1' | '\u1ec3' | '\u1ec5' | '\u1ec7' | '\u1ec9' | '\u1ecb' | '\u1ecd' | '\u1ecf' | '\u1ed1' | '\u1ed3' | '\u1ed5' | '\u1ed7' | '\u1ed9' | '\u1edb' | '\u1edd' | '\u1edf' | '\u1ee1' | '\u1ee3' | '\u1ee5' | '\u1ee7' | '\u1ee9' | '\u1eeb' | '\u1eed' | '\u1eef' | '\u1ef1' | '\u1ef3' | '\u1ef5' | '\u1ef7' | '\u1ef9' | '\u1efb' | '\u1efd' | '\u1eff' | '\u1f00' | '\u1f01' | '\u1f02' | '\u1f03' | '\u1f04' | '\u1f05' | '\u1f06' | '\u1f07' | '\u1f10' | '\u1f11' | '\u1f12' | '\u1f13' | '\u1f14' | '\u1f15' | '\u1f20' | '\u1f21' | '\u1f22' | '\u1f23' | '\u1f24' | '\u1f25' | '\u1f26' | '\u1f27' | '\u1f30' | '\u1f31' | '\u1f32' | '\u1f33' | '\u1f34' | '\u1f35' | '\u1f36' | '\u1f37' | '\u1f40' | '\u1f41' | '\u1f42' | '\u1f43' | '\u1f44' | '\u1f45' | '\u1f50' | '\u1f51' | '\u1f52' | '\u1f53' | '\u1f54' | '\u1f55' | '\u1f56' | '\u1f57' | '\u1f60' | '\u1f61' | '\u1f62' | '\u1f63' | '\u1f64' | '\u1f65' | '\u1f66' | '\u1f67' | '\u1f70' | '\u1f71' | '\u1f72' | '\u1f73' | '\u1f74' | '\u1f75' | '\u1f76' | '\u1f77' | '\u1f78' | '\u1f79' | '\u1f7a' | '\u1f7b' | '\u1f7c' | '\u1f7d' | '\u1f80' | '\u1f81' | '\u1f82' | '\u1f83' | '\u1f84' | '\u1f85' | '\u1f86' | '\u1f87' | '\u1f90' | '\u1f91' | '\u1f92' | '\u1f93' | '\u1f94' | '\u1f95' | '\u1f96' | '\u1f97' | '\u1fa0' | '\u1fa1' | '\u1fa2' | '\u1fa3' | '\u1fa4' | '\u1fa5' | '\u1fa6' | '\u1fa7' | '\u1fb0' | '\u1fb1' | '\u1fb2' | '\u1fb3' | '\u1fb4' | '\u1fb6' | '\u1fb7' | '\u1fbe' | '\u1fc2' | '\u1fc3' | '\u1fc4' | '\u1fc6' | '\u1fc7' | '\u1fd0' | '\u1fd1' | '\u1fd2' | '\u1fd3' | '\u1fd6' | '\u1fd7' | '\u1fe0' | '\u1fe1' | '\u1fe2' | '\u1fe3' | '\u1fe4' | '\u1fe5' | '\u1fe6' | '\u1fe7' | '\u1ff2' | '\u1ff3' | '\u1ff4' | '\u1ff6' | '\u1ff7' | '\u210a' | '\u210e' | '\u210f' | '\u2113' | '\u212f' | '\u2134' | '\u2139' | '\u213c' | '\u213d' | '\u2146' | '\u2147' | '\u2148' | '\u2149' | '\u214e' | '\u2184' | '\u2c30' | '\u2c31' | '\u2c32' | '\u2c33' | '\u2c34' | '\u2c35' | '\u2c36' | '\u2c37' | '\u2c38' | '\u2c39' | '\u2c3a' | '\u2c3b' | '\u2c3c' | '\u2c3d' | '\u2c3e' | '\u2c3f' | '\u2c40' | '\u2c41' | '\u2c42' | '\u2c43' | '\u2c44' | '\u2c45' | '\u2c46' | '\u2c47' | '\u2c48' | '\u2c49' | '\u2c4a' | '\u2c4b' | '\u2c4c' | '\u2c4d' | '\u2c4e' | '\u2c4f' | '\u2c50' | '\u2c51' | '\u2c52' | '\u2c53' | '\u2c54' | '\u2c55' | '\u2c56' | '\u2c57' | '\u2c58' | '\u2c59' | '\u2c5a' | '\u2c5b' | '\u2c5c' | '\u2c5d' | '\u2c5e' | '\u2c61' | '\u2c65' | '\u2c66' | '\u2c68' | '\u2c6a' | '\u2c6c' | '\u2c71' | '\u2c73' | '\u2c74' | '\u2c76' | '\u2c77' | '\u2c78' | '\u2c79' | '\u2c7a' | '\u2c7b' | '\u2c81' | '\u2c83' | '\u2c85' | '\u2c87' | '\u2c89' | '\u2c8b' | '\u2c8d' | '\u2c8f' | '\u2c91' | '\u2c93' | '\u2c95' | '\u2c97' | '\u2c99' | '\u2c9b' | '\u2c9d' | '\u2c9f' | '\u2ca1' | '\u2ca3' | '\u2ca5' | '\u2ca7' | '\u2ca9' | '\u2cab' | '\u2cad' | '\u2caf' | '\u2cb1' | '\u2cb3' | '\u2cb5' | '\u2cb7' | '\u2cb9' | '\u2cbb' | '\u2cbd' | '\u2cbf' | '\u2cc1' | '\u2cc3' | '\u2cc5' | '\u2cc7' | '\u2cc9' | '\u2ccb' | '\u2ccd' | '\u2ccf' | '\u2cd1' | '\u2cd3' | '\u2cd5' | '\u2cd7' | '\u2cd9' | '\u2cdb' | '\u2cdd' | '\u2cdf' | '\u2ce1' | '\u2ce3' | '\u2ce4' | '\u2cec' | '\u2cee' | '\u2cf3' | '\u2d00' | '\u2d01' | '\u2d02' | '\u2d03' | '\u2d04' | '\u2d05' | '\u2d06' | '\u2d07' | '\u2d08' | '\u2d09' | '\u2d0a' | '\u2d0b' | '\u2d0c' | '\u2d0d' | '\u2d0e' | '\u2d0f' | '\u2d10' | '\u2d11' | '\u2d12' | '\u2d13' | '\u2d14' | '\u2d15' | '\u2d16' | '\u2d17' | '\u2d18' | '\u2d19' | '\u2d1a' | '\u2d1b' | '\u2d1c' | '\u2d1d' | '\u2d1e' | '\u2d1f' | '\u2d20' | '\u2d21' | '\u2d22' | '\u2d23' | '\u2d24' | '\u2d25' | '\u2d27' | '\u2d2d' | '\ua641' | '\ua643' | '\ua645' | '\ua647' | '\ua649' | '\ua64b' | '\ua64d' | '\ua64f' | '\ua651' | '\ua653' | '\ua655' | '\ua657' | '\ua659' | '\ua65b' | '\ua65d' | '\ua65f' | '\ua661' | '\ua663' | '\ua665' | '\ua667' | '\ua669' | '\ua66b' | '\ua66d' | '\ua681' | '\ua683' | '\ua685' | '\ua687' | '\ua689' | '\ua68b' | '\ua68d' | '\ua68f' | '\ua691' | '\ua693' | '\ua695' | '\ua697' | '\ua723' | '\ua725' | '\ua727' | '\ua729' | '\ua72b' | '\ua72d' | '\ua72f' | '\ua730' | '\ua731' | '\ua733' | '\ua735' | '\ua737' | '\ua739' | '\ua73b' | '\ua73d' | '\ua73f' | '\ua741' | '\ua743' | '\ua745' | '\ua747' | '\ua749' | '\ua74b' | '\ua74d' | '\ua74f' | '\ua751' | '\ua753' | '\ua755' | '\ua757' | '\ua759' | '\ua75b' | '\ua75d' | '\ua75f' | '\ua761' | '\ua763' | '\ua765' | '\ua767' | '\ua769' | '\ua76b' | '\ua76d' | '\ua76f' | '\ua771' | '\ua772' | '\ua773' | '\ua774' | '\ua775' | '\ua776' | '\ua777' | '\ua778' | '\ua77a' | '\ua77c' | '\ua77f' | '\ua781' | '\ua783' | '\ua785' | '\ua787' | '\ua78c' | '\ua78e' | '\ua791' | '\ua793' | '\ua7a1' | '\ua7a3' | '\ua7a5' | '\ua7a7' | '\ua7a9' | '\ua7fa' | '\ufb00' | '\ufb01' | '\ufb02' | '\ufb03' | '\ufb04' | '\ufb05' | '\ufb06' | '\ufb13' | '\ufb14' | '\ufb15' | '\ufb16' | '\ufb17' | '\uff41' | '\uff42' | '\uff43' | '\uff44' | '\uff45' | '\uff46' | '\uff47' | '\uff48' | '\uff49' | '\uff4a' | '\uff4b' | '\uff4c' | '\uff4d' | '\uff4e' | '\uff4f' | '\uff50' | '\uff51' | '\uff52' | '\uff53' | '\uff54' | '\uff55' | '\uff56' | '\uff57' | '\uff58' | '\uff59' | '\uff5a' | '\u10428' | '\u10429' | '\u1042a' | '\u1042b' | '\u1042c' | '\u1042d' | '\u1042e' | '\u1042f' | '\u10430' | '\u10431' | '\u10432' | '\u10433' | '\u10434' | '\u10435' | '\u10436' | '\u10437' | '\u10438' | '\u10439' | '\u1043a' | '\u1043b' | '\u1043c' | '\u1043d' | '\u1043e' | '\u1043f' | '\u10440' | '\u10441' | '\u10442' | '\u10443' | '\u10444' | '\u10445' | '\u10446' | '\u10447' | '\u10448' | '\u10449' | '\u1044a' | '\u1044b' | '\u1044c' | '\u1044d' | '\u1044e' | '\u1044f' | '\u1d41a' | '\u1d41b' | '\u1d41c' | '\u1d41d' | '\u1d41e' | '\u1d41f' | '\u1d420' | '\u1d421' | '\u1d422' | '\u1d423' | '\u1d424' | '\u1d425' | '\u1d426' | '\u1d427' | '\u1d428' | '\u1d429' | '\u1d42a' | '\u1d42b' | '\u1d42c' | '\u1d42d' | '\u1d42e' | '\u1d42f' | '\u1d430' | '\u1d431' | '\u1d432' | '\u1d433' | '\u1d44e' | '\u1d44f' | '\u1d450' | '\u1d451' | '\u1d452' | '\u1d453' | '\u1d454' | '\u1d456' | '\u1d457' | '\u1d458' | '\u1d459' | '\u1d45a' | '\u1d45b' | '\u1d45c' | '\u1d45d' | '\u1d45e' | '\u1d45f' | '\u1d460' | '\u1d461' | '\u1d462' | '\u1d463' | '\u1d464' | '\u1d465' | '\u1d466' | '\u1d467' | '\u1d482' | '\u1d483' | '\u1d484' | '\u1d485' | '\u1d486' | '\u1d487' | '\u1d488' | '\u1d489' | '\u1d48a' | '\u1d48b' | '\u1d48c' | '\u1d48d' | '\u1d48e' | '\u1d48f' | '\u1d490' | '\u1d491' | '\u1d492' | '\u1d493' | '\u1d494' | '\u1d495' | '\u1d496' | '\u1d497' | '\u1d498' | '\u1d499' | '\u1d49a' | '\u1d49b' | '\u1d4b6' | '\u1d4b7' | '\u1d4b8' | '\u1d4b9' | '\u1d4bb' | '\u1d4bd' | '\u1d4be' | '\u1d4bf' | '\u1d4c0' | '\u1d4c1' | '\u1d4c2' | '\u1d4c3' | '\u1d4c5' | '\u1d4c6' | '\u1d4c7' | '\u1d4c8' | '\u1d4c9' | '\u1d4ca' | '\u1d4cb' | '\u1d4cc' | '\u1d4cd' | '\u1d4ce' | '\u1d4cf' | '\u1d4ea' | '\u1d4eb' | '\u1d4ec' | '\u1d4ed' | '\u1d4ee' | '\u1d4ef' | '\u1d4f0' | '\u1d4f1' | '\u1d4f2' | '\u1d4f3' | '\u1d4f4' | '\u1d4f5' | '\u1d4f6' | '\u1d4f7' | '\u1d4f8' | '\u1d4f9' | '\u1d4fa' | '\u1d4fb' | '\u1d4fc' | '\u1d4fd' | '\u1d4fe' | '\u1d4ff' | '\u1d500' | '\u1d501' | '\u1d502' | '\u1d503' | '\u1d51e' | '\u1d51f' | '\u1d520' | '\u1d521' | '\u1d522' | '\u1d523' | '\u1d524' | '\u1d525' | '\u1d526' | '\u1d527' | '\u1d528' | '\u1d529' | '\u1d52a' | '\u1d52b' | '\u1d52c' | '\u1d52d' | '\u1d52e' | '\u1d52f' | '\u1d530' | '\u1d531' | '\u1d532' | '\u1d533' | '\u1d534' | '\u1d535' | '\u1d536' | '\u1d537' | '\u1d552' | '\u1d553' | '\u1d554' | '\u1d555' | '\u1d556' | '\u1d557' | '\u1d558' | '\u1d559' | '\u1d55a' | '\u1d55b' | '\u1d55c' | '\u1d55d' | '\u1d55e' | '\u1d55f' | '\u1d560' | '\u1d561' | '\u1d562' | '\u1d563' | '\u1d564' | '\u1d565' | '\u1d566' | '\u1d567' | '\u1d568' | '\u1d569' | '\u1d56a' | '\u1d56b' | '\u1d586' | '\u1d587' | '\u1d588' | '\u1d589' | '\u1d58a' | '\u1d58b' | '\u1d58c' | '\u1d58d' | '\u1d58e' | '\u1d58f' | '\u1d590' | '\u1d591' | '\u1d592' | '\u1d593' | '\u1d594' | '\u1d595' | '\u1d596' | '\u1d597' | '\u1d598' | '\u1d599' | '\u1d59a' | '\u1d59b' | '\u1d59c' | '\u1d59d' | '\u1d59e' | '\u1d59f' | '\u1d5ba' | '\u1d5bb' | '\u1d5bc' | '\u1d5bd' | '\u1d5be' | '\u1d5bf' | '\u1d5c0' | '\u1d5c1' | '\u1d5c2' | '\u1d5c3' | '\u1d5c4' | '\u1d5c5' | '\u1d5c6' | '\u1d5c7' | '\u1d5c8' | '\u1d5c9' | '\u1d5ca' | '\u1d5cb' | '\u1d5cc' | '\u1d5cd' | '\u1d5ce' | '\u1d5cf' | '\u1d5d0' | '\u1d5d1' | '\u1d5d2' | '\u1d5d3' | '\u1d5ee' | '\u1d5ef' | '\u1d5f0' | '\u1d5f1' | '\u1d5f2' | '\u1d5f3' | '\u1d5f4' | '\u1d5f5' | '\u1d5f6' | '\u1d5f7' | '\u1d5f8' | '\u1d5f9' | '\u1d5fa' | '\u1d5fb' | '\u1d5fc' | '\u1d5fd' | '\u1d5fe' | '\u1d5ff' | '\u1d600' | '\u1d601' | '\u1d602' | '\u1d603' | '\u1d604' | '\u1d605' | '\u1d606' | '\u1d607' | '\u1d622' | '\u1d623' | '\u1d624' | '\u1d625' | '\u1d626' | '\u1d627' | '\u1d628' | '\u1d629' | '\u1d62a' | '\u1d62b' | '\u1d62c' | '\u1d62d' | '\u1d62e' | '\u1d62f' | '\u1d630' | '\u1d631' | '\u1d632' | '\u1d633' | '\u1d634' | '\u1d635' | '\u1d636' | '\u1d637' | '\u1d638' | '\u1d639' | '\u1d63a' | '\u1d63b' | '\u1d656' | '\u1d657' | '\u1d658' | '\u1d659' | '\u1d65a' | '\u1d65b' | '\u1d65c' | '\u1d65d' | '\u1d65e' | '\u1d65f' | '\u1d660' | '\u1d661' | '\u1d662' | '\u1d663' | '\u1d664' | '\u1d665' | '\u1d666' | '\u1d667' | '\u1d668' | '\u1d669' | '\u1d66a' | '\u1d66b' | '\u1d66c' | '\u1d66d' | '\u1d66e' | '\u1d66f' | '\u1d68a' | '\u1d68b' | '\u1d68c' | '\u1d68d' | '\u1d68e' | '\u1d68f' | '\u1d690' | '\u1d691' | '\u1d692' | '\u1d693' | '\u1d694' | '\u1d695' | '\u1d696' | '\u1d697' | '\u1d698' | '\u1d699' | '\u1d69a' | '\u1d69b' | '\u1d69c' | '\u1d69d' | '\u1d69e' | '\u1d69f' | '\u1d6a0' | '\u1d6a1' | '\u1d6a2' | '\u1d6a3' | '\u1d6a4' | '\u1d6a5' | '\u1d6c2' | '\u1d6c3' | '\u1d6c4' | '\u1d6c5' | '\u1d6c6' | '\u1d6c7' | '\u1d6c8' | '\u1d6c9' | '\u1d6ca' | '\u1d6cb' | '\u1d6cc' | '\u1d6cd' | '\u1d6ce' | '\u1d6cf' | '\u1d6d0' | '\u1d6d1' | '\u1d6d2' | '\u1d6d3' | '\u1d6d4' | '\u1d6d5' | '\u1d6d6' | '\u1d6d7' | '\u1d6d8' | '\u1d6d9' | '\u1d6da' | '\u1d6dc' | '\u1d6dd' | '\u1d6de' | '\u1d6df' | '\u1d6e0' | '\u1d6e1' | '\u1d6fc' | '\u1d6fd' | '\u1d6fe' | '\u1d6ff' | '\u1d700' | '\u1d701' | '\u1d702' | '\u1d703' | '\u1d704' | '\u1d705' | '\u1d706' | '\u1d707' | '\u1d708' | '\u1d709' | '\u1d70a' | '\u1d70b' | '\u1d70c' | '\u1d70d' | '\u1d70e' | '\u1d70f' | '\u1d710' | '\u1d711' | '\u1d712' | '\u1d713' | '\u1d714' | '\u1d716' | '\u1d717' | '\u1d718' | '\u1d719' | '\u1d71a' | '\u1d71b' | '\u1d736' | '\u1d737' | '\u1d738' | '\u1d739' | '\u1d73a' | '\u1d73b' | '\u1d73c' | '\u1d73d' | '\u1d73e' | '\u1d73f' | '\u1d740' | '\u1d741' | '\u1d742' | '\u1d743' | '\u1d744' | '\u1d745' | '\u1d746' | '\u1d747' | '\u1d748' | '\u1d749' | '\u1d74a' | '\u1d74b' | '\u1d74c' | '\u1d74d' | '\u1d74e' | '\u1d750' | '\u1d751' | '\u1d752' | '\u1d753' | '\u1d754' | '\u1d755' | '\u1d770' | '\u1d771' | '\u1d772' | '\u1d773' | '\u1d774' | '\u1d775' | '\u1d776' | '\u1d777' | '\u1d778' | '\u1d779' | '\u1d77a' | '\u1d77b' | '\u1d77c' | '\u1d77d' | '\u1d77e' | '\u1d77f' | '\u1d780' | '\u1d781' | '\u1d782' | '\u1d783' | '\u1d784' | '\u1d785' | '\u1d786' | '\u1d787' | '\u1d788' | '\u1d78a' | '\u1d78b' | '\u1d78c' | '\u1d78d' | '\u1d78e' | '\u1d78f' | '\u1d7aa' | '\u1d7ab' | '\u1d7ac' | '\u1d7ad' | '\u1d7ae' | '\u1d7af' | '\u1d7b0' | '\u1d7b1' | '\u1d7b2' | '\u1d7b3' | '\u1d7b4' | '\u1d7b5' | '\u1d7b6' | '\u1d7b7' | '\u1d7b8' | '\u1d7b9' | '\u1d7ba' | '\u1d7bb' | '\u1d7bc' | '\u1d7bd' | '\u1d7be' | '\u1d7bf' | '\u1d7c0' | '\u1d7c1' | '\u1d7c2' | '\u1d7c4' | '\u1d7c5' | '\u1d7c6' | '\u1d7c7' | '\u1d7c8' | '\u1d7c9' | '\u1d7cb' ;

fragment // All Unicode characters of the Lu (Letter, uppercase) class
Lu : '\u0041' | '\u0042' | '\u0043' | '\u0044' | '\u0045' | '\u0046' | '\u0047' | '\u0048' | '\u0049' | '\u004a' | '\u004b' | '\u004c' | '\u004d' | '\u004e' | '\u004f' | '\u0050' | '\u0051' | '\u0052' | '\u0053' | '\u0054' | '\u0055' | '\u0056' | '\u0057' | '\u0058' | '\u0059' | '\u005a' | '\u00c0' | '\u00c1' | '\u00c2' | '\u00c3' | '\u00c4' | '\u00c5' | '\u00c6' | '\u00c7' | '\u00c8' | '\u00c9' | '\u00ca' | '\u00cb' | '\u00cc' | '\u00cd' | '\u00ce' | '\u00cf' | '\u00d0' | '\u00d1' | '\u00d2' | '\u00d3' | '\u00d4' | '\u00d5' | '\u00d6' | '\u00d8' | '\u00d9' | '\u00da' | '\u00db' | '\u00dc' | '\u00dd' | '\u00de' | '\u0100' | '\u0102' | '\u0104' | '\u0106' | '\u0108' | '\u010a' | '\u010c' | '\u010e' | '\u0110' | '\u0112' | '\u0114' | '\u0116' | '\u0118' | '\u011a' | '\u011c' | '\u011e' | '\u0120' | '\u0122' | '\u0124' | '\u0126' | '\u0128' | '\u012a' | '\u012c' | '\u012e' | '\u0130' | '\u0132' | '\u0134' | '\u0136' | '\u0139' | '\u013b' | '\u013d' | '\u013f' | '\u0141' | '\u0143' | '\u0145' | '\u0147' | '\u014a' | '\u014c' | '\u014e' | '\u0150' | '\u0152' | '\u0154' | '\u0156' | '\u0158' | '\u015a' | '\u015c' | '\u015e' | '\u0160' | '\u0162' | '\u0164' | '\u0166' | '\u0168' | '\u016a' | '\u016c' | '\u016e' | '\u0170' | '\u0172' | '\u0174' | '\u0176' | '\u0178' | '\u0179' | '\u017b' | '\u017d' | '\u0181' | '\u0182' | '\u0184' | '\u0186' | '\u0187' | '\u0189' | '\u018a' | '\u018b' | '\u018e' | '\u018f' | '\u0190' | '\u0191' | '\u0193' | '\u0194' | '\u0196' | '\u0197' | '\u0198' | '\u019c' | '\u019d' | '\u019f' | '\u01a0' | '\u01a2' | '\u01a4' | '\u01a6' | '\u01a7' | '\u01a9' | '\u01ac' | '\u01ae' | '\u01af' | '\u01b1' | '\u01b2' | '\u01b3' | '\u01b5' | '\u01b7' | '\u01b8' | '\u01bc' | '\u01c4' | '\u01c7' | '\u01ca' | '\u01cd' | '\u01cf' | '\u01d1' | '\u01d3' | '\u01d5' | '\u01d7' | '\u01d9' | '\u01db' | '\u01de' | '\u01e0' | '\u01e2' | '\u01e4' | '\u01e6' | '\u01e8' | '\u01ea' | '\u01ec' | '\u01ee' | '\u01f1' | '\u01f4' | '\u01f6' | '\u01f7' | '\u01f8' | '\u01fa' | '\u01fc' | '\u01fe' | '\u0200' | '\u0202' | '\u0204' | '\u0206' | '\u0208' | '\u020a' | '\u020c' | '\u020e' | '\u0210' | '\u0212' | '\u0214' | '\u0216' | '\u0218' | '\u021a' | '\u021c' | '\u021e' | '\u0220' | '\u0222' | '\u0224' | '\u0226' | '\u0228' | '\u022a' | '\u022c' | '\u022e' | '\u0230' | '\u0232' | '\u023a' | '\u023b' | '\u023d' | '\u023e' | '\u0241' | '\u0243' | '\u0244' | '\u0245' | '\u0246' | '\u0248' | '\u024a' | '\u024c' | '\u024e' | '\u0370' | '\u0372' | '\u0376' | '\u0386' | '\u0388' | '\u0389' | '\u038a' | '\u038c' | '\u038e' | '\u038f' | '\u0391' | '\u0392' | '\u0393' | '\u0394' | '\u0395' | '\u0396' | '\u0397' | '\u0398' | '\u0399' | '\u039a' | '\u039b' | '\u039c' | '\u039d' | '\u039e' | '\u039f' | '\u03a0' | '\u03a1' | '\u03a3' | '\u03a4' | '\u03a5' | '\u03a6' | '\u03a7' | '\u03a8' | '\u03a9' | '\u03aa' | '\u03ab' | '\u03cf' | '\u03d2' | '\u03d3' | '\u03d4' | '\u03d8' | '\u03da' | '\u03dc' | '\u03de' | '\u03e0' | '\u03e2' | '\u03e4' | '\u03e6' | '\u03e8' | '\u03ea' | '\u03ec' | '\u03ee' | '\u03f4' | '\u03f7' | '\u03f9' | '\u03fa' | '\u03fd' | '\u03fe' | '\u03ff' | '\u0400' | '\u0401' | '\u0402' | '\u0403' | '\u0404' | '\u0405' | '\u0406' | '\u0407' | '\u0408' | '\u0409' | '\u040a' | '\u040b' | '\u040c' | '\u040d' | '\u040e' | '\u040f' | '\u0410' | '\u0411' | '\u0412' | '\u0413' | '\u0414' | '\u0415' | '\u0416' | '\u0417' | '\u0418' | '\u0419' | '\u041a' | '\u041b' | '\u041c' | '\u041d' | '\u041e' | '\u041f' | '\u0420' | '\u0421' | '\u0422' | '\u0423' | '\u0424' | '\u0425' | '\u0426' | '\u0427' | '\u0428' | '\u0429' | '\u042a' | '\u042b' | '\u042c' | '\u042d' | '\u042e' | '\u042f' | '\u0460' | '\u0462' | '\u0464' | '\u0466' | '\u0468' | '\u046a' | '\u046c' | '\u046e' | '\u0470' | '\u0472' | '\u0474' | '\u0476' | '\u0478' | '\u047a' | '\u047c' | '\u047e' | '\u0480' | '\u048a' | '\u048c' | '\u048e' | '\u0490' | '\u0492' | '\u0494' | '\u0496' | '\u0498' | '\u049a' | '\u049c' | '\u049e' | '\u04a0' | '\u04a2' | '\u04a4' | '\u04a6' | '\u04a8' | '\u04aa' | '\u04ac' | '\u04ae' | '\u04b0' | '\u04b2' | '\u04b4' | '\u04b6' | '\u04b8' | '\u04ba' | '\u04bc' | '\u04be' | '\u04c0' | '\u04c1' | '\u04c3' | '\u04c5' | '\u04c7' | '\u04c9' | '\u04cb' | '\u04cd' | '\u04d0' | '\u04d2' | '\u04d4' | '\u04d6' | '\u04d8' | '\u04da' | '\u04dc' | '\u04de' | '\u04e0' | '\u04e2' | '\u04e4' | '\u04e6' | '\u04e8' | '\u04ea' | '\u04ec' | '\u04ee' | '\u04f0' | '\u04f2' | '\u04f4' | '\u04f6' | '\u04f8' | '\u04fa' | '\u04fc' | '\u04fe' | '\u0500' | '\u0502' | '\u0504' | '\u0506' | '\u0508' | '\u050a' | '\u050c' | '\u050e' | '\u0510' | '\u0512' | '\u0514' | '\u0516' | '\u0518' | '\u051a' | '\u051c' | '\u051e' | '\u0520' | '\u0522' | '\u0524' | '\u0526' | '\u0531' | '\u0532' | '\u0533' | '\u0534' | '\u0535' | '\u0536' | '\u0537' | '\u0538' | '\u0539' | '\u053a' | '\u053b' | '\u053c' | '\u053d' | '\u053e' | '\u053f' | '\u0540' | '\u0541' | '\u0542' | '\u0543' | '\u0544' | '\u0545' | '\u0546' | '\u0547' | '\u0548' | '\u0549' | '\u054a' | '\u054b' | '\u054c' | '\u054d' | '\u054e' | '\u054f' | '\u0550' | '\u0551' | '\u0552' | '\u0553' | '\u0554' | '\u0555' | '\u0556' | '\u10a0' | '\u10a1' | '\u10a2' | '\u10a3' | '\u10a4' | '\u10a5' | '\u10a6' | '\u10a7' | '\u10a8' | '\u10a9' | '\u10aa' | '\u10ab' | '\u10ac' | '\u10ad' | '\u10ae' | '\u10af' | '\u10b0' | '\u10b1' | '\u10b2' | '\u10b3' | '\u10b4' | '\u10b5' | '\u10b6' | '\u10b7' | '\u10b8' | '\u10b9' | '\u10ba' | '\u10bb' | '\u10bc' | '\u10bd' | '\u10be' | '\u10bf' | '\u10c0' | '\u10c1' | '\u10c2' | '\u10c3' | '\u10c4' | '\u10c5' | '\u10c7' | '\u10cd' | '\u1e00' | '\u1e02' | '\u1e04' | '\u1e06' | '\u1e08' | '\u1e0a' | '\u1e0c' | '\u1e0e' | '\u1e10' | '\u1e12' | '\u1e14' | '\u1e16' | '\u1e18' | '\u1e1a' | '\u1e1c' | '\u1e1e' | '\u1e20' | '\u1e22' | '\u1e24' | '\u1e26' | '\u1e28' | '\u1e2a' | '\u1e2c' | '\u1e2e' | '\u1e30' | '\u1e32' | '\u1e34' | '\u1e36' | '\u1e38' | '\u1e3a' | '\u1e3c' | '\u1e3e' | '\u1e40' | '\u1e42' | '\u1e44' | '\u1e46' | '\u1e48' | '\u1e4a' | '\u1e4c' | '\u1e4e' | '\u1e50' | '\u1e52' | '\u1e54' | '\u1e56' | '\u1e58' | '\u1e5a' | '\u1e5c' | '\u1e5e' | '\u1e60' | '\u1e62' | '\u1e64' | '\u1e66' | '\u1e68' | '\u1e6a' | '\u1e6c' | '\u1e6e' | '\u1e70' | '\u1e72' | '\u1e74' | '\u1e76' | '\u1e78' | '\u1e7a' | '\u1e7c' | '\u1e7e' | '\u1e80' | '\u1e82' | '\u1e84' | '\u1e86' | '\u1e88' | '\u1e8a' | '\u1e8c' | '\u1e8e' | '\u1e90' | '\u1e92' | '\u1e94' | '\u1e9e' | '\u1ea0' | '\u1ea2' | '\u1ea4' | '\u1ea6' | '\u1ea8' | '\u1eaa' | '\u1eac' | '\u1eae' | '\u1eb0' | '\u1eb2' | '\u1eb4' | '\u1eb6' | '\u1eb8' | '\u1eba' | '\u1ebc' | '\u1ebe' | '\u1ec0' | '\u1ec2' | '\u1ec4' | '\u1ec6' | '\u1ec8' | '\u1eca' | '\u1ecc' | '\u1ece' | '\u1ed0' | '\u1ed2' | '\u1ed4' | '\u1ed6' | '\u1ed8' | '\u1eda' | '\u1edc' | '\u1ede' | '\u1ee0' | '\u1ee2' | '\u1ee4' | '\u1ee6' | '\u1ee8' | '\u1eea' | '\u1eec' | '\u1eee' | '\u1ef0' | '\u1ef2' | '\u1ef4' | '\u1ef6' | '\u1ef8' | '\u1efa' | '\u1efc' | '\u1efe' | '\u1f08' | '\u1f09' | '\u1f0a' | '\u1f0b' | '\u1f0c' | '\u1f0d' | '\u1f0e' | '\u1f0f' | '\u1f18' | '\u1f19' | '\u1f1a' | '\u1f1b' | '\u1f1c' | '\u1f1d' | '\u1f28' | '\u1f29' | '\u1f2a' | '\u1f2b' | '\u1f2c' | '\u1f2d' | '\u1f2e' | '\u1f2f' | '\u1f38' | '\u1f39' | '\u1f3a' | '\u1f3b' | '\u1f3c' | '\u1f3d' | '\u1f3e' | '\u1f3f' | '\u1f48' | '\u1f49' | '\u1f4a' | '\u1f4b' | '\u1f4c' | '\u1f4d' | '\u1f59' | '\u1f5b' | '\u1f5d' | '\u1f5f' | '\u1f68' | '\u1f69' | '\u1f6a' | '\u1f6b' | '\u1f6c' | '\u1f6d' | '\u1f6e' | '\u1f6f' | '\u1fb8' | '\u1fb9' | '\u1fba' | '\u1fbb' | '\u1fc8' | '\u1fc9' | '\u1fca' | '\u1fcb' | '\u1fd8' | '\u1fd9' | '\u1fda' | '\u1fdb' | '\u1fe8' | '\u1fe9' | '\u1fea' | '\u1feb' | '\u1fec' | '\u1ff8' | '\u1ff9' | '\u1ffa' | '\u1ffb' | '\u2102' | '\u2107' | '\u210b' | '\u210c' | '\u210d' | '\u2110' | '\u2111' | '\u2112' | '\u2115' | '\u2119' | '\u211a' | '\u211b' | '\u211c' | '\u211d' | '\u2124' | '\u2126' | '\u2128' | '\u212a' | '\u212b' | '\u212c' | '\u212d' | '\u2130' | '\u2131' | '\u2132' | '\u2133' | '\u213e' | '\u213f' | '\u2145' | '\u2183' | '\u2c00' | '\u2c01' | '\u2c02' | '\u2c03' | '\u2c04' | '\u2c05' | '\u2c06' | '\u2c07' | '\u2c08' | '\u2c09' | '\u2c0a' | '\u2c0b' | '\u2c0c' | '\u2c0d' | '\u2c0e' | '\u2c0f' | '\u2c10' | '\u2c11' | '\u2c12' | '\u2c13' | '\u2c14' | '\u2c15' | '\u2c16' | '\u2c17' | '\u2c18' | '\u2c19' | '\u2c1a' | '\u2c1b' | '\u2c1c' | '\u2c1d' | '\u2c1e' | '\u2c1f' | '\u2c20' | '\u2c21' | '\u2c22' | '\u2c23' | '\u2c24' | '\u2c25' | '\u2c26' | '\u2c27' | '\u2c28' | '\u2c29' | '\u2c2a' | '\u2c2b' | '\u2c2c' | '\u2c2d' | '\u2c2e' | '\u2c60' | '\u2c62' | '\u2c63' | '\u2c64' | '\u2c67' | '\u2c69' | '\u2c6b' | '\u2c6d' | '\u2c6e' | '\u2c6f' | '\u2c70' | '\u2c72' | '\u2c75' | '\u2c7e' | '\u2c7f' | '\u2c80' | '\u2c82' | '\u2c84' | '\u2c86' | '\u2c88' | '\u2c8a' | '\u2c8c' | '\u2c8e' | '\u2c90' | '\u2c92' | '\u2c94' | '\u2c96' | '\u2c98' | '\u2c9a' | '\u2c9c' | '\u2c9e' | '\u2ca0' | '\u2ca2' | '\u2ca4' | '\u2ca6' | '\u2ca8' | '\u2caa' | '\u2cac' | '\u2cae' | '\u2cb0' | '\u2cb2' | '\u2cb4' | '\u2cb6' | '\u2cb8' | '\u2cba' | '\u2cbc' | '\u2cbe' | '\u2cc0' | '\u2cc2' | '\u2cc4' | '\u2cc6' | '\u2cc8' | '\u2cca' | '\u2ccc' | '\u2cce' | '\u2cd0' | '\u2cd2' | '\u2cd4' | '\u2cd6' | '\u2cd8' | '\u2cda' | '\u2cdc' | '\u2cde' | '\u2ce0' | '\u2ce2' | '\u2ceb' | '\u2ced' | '\u2cf2' | '\ua640' | '\ua642' | '\ua644' | '\ua646' | '\ua648' | '\ua64a' | '\ua64c' | '\ua64e' | '\ua650' | '\ua652' | '\ua654' | '\ua656' | '\ua658' | '\ua65a' | '\ua65c' | '\ua65e' | '\ua660' | '\ua662' | '\ua664' | '\ua666' | '\ua668' | '\ua66a' | '\ua66c' | '\ua680' | '\ua682' | '\ua684' | '\ua686' | '\ua688' | '\ua68a' | '\ua68c' | '\ua68e' | '\ua690' | '\ua692' | '\ua694' | '\ua696' | '\ua722' | '\ua724' | '\ua726' | '\ua728' | '\ua72a' | '\ua72c' | '\ua72e' | '\ua732' | '\ua734' | '\ua736' | '\ua738' | '\ua73a' | '\ua73c' | '\ua73e' | '\ua740' | '\ua742' | '\ua744' | '\ua746' | '\ua748' | '\ua74a' | '\ua74c' | '\ua74e' | '\ua750' | '\ua752' | '\ua754' | '\ua756' | '\ua758' | '\ua75a' | '\ua75c' | '\ua75e' | '\ua760' | '\ua762' | '\ua764' | '\ua766' | '\ua768' | '\ua76a' | '\ua76c' | '\ua76e' | '\ua779' | '\ua77b' | '\ua77d' | '\ua77e' | '\ua780' | '\ua782' | '\ua784' | '\ua786' | '\ua78b' | '\ua78d' | '\ua790' | '\ua792' | '\ua7a0' | '\ua7a2' | '\ua7a4' | '\ua7a6' | '\ua7a8' | '\ua7aa' | '\uff21' | '\uff22' | '\uff23' | '\uff24' | '\uff25' | '\uff26' | '\uff27' | '\uff28' | '\uff29' | '\uff2a' | '\uff2b' | '\uff2c' | '\uff2d' | '\uff2e' | '\uff2f' | '\uff30' | '\uff31' | '\uff32' | '\uff33' | '\uff34' | '\uff35' | '\uff36' | '\uff37' | '\uff38' | '\uff39' | '\uff3a' | '\u10400' | '\u10401' | '\u10402' | '\u10403' | '\u10404' | '\u10405' | '\u10406' | '\u10407' | '\u10408' | '\u10409' | '\u1040a' | '\u1040b' | '\u1040c' | '\u1040d' | '\u1040e' | '\u1040f' | '\u10410' | '\u10411' | '\u10412' | '\u10413' | '\u10414' | '\u10415' | '\u10416' | '\u10417' | '\u10418' | '\u10419' | '\u1041a' | '\u1041b' | '\u1041c' | '\u1041d' | '\u1041e' | '\u1041f' | '\u10420' | '\u10421' | '\u10422' | '\u10423' | '\u10424' | '\u10425' | '\u10426' | '\u10427' | '\u1d400' | '\u1d401' | '\u1d402' | '\u1d403' | '\u1d404' | '\u1d405' | '\u1d406' | '\u1d407' | '\u1d408' | '\u1d409' | '\u1d40a' | '\u1d40b' | '\u1d40c' | '\u1d40d' | '\u1d40e' | '\u1d40f' | '\u1d410' | '\u1d411' | '\u1d412' | '\u1d413' | '\u1d414' | '\u1d415' | '\u1d416' | '\u1d417' | '\u1d418' | '\u1d419' | '\u1d434' | '\u1d435' | '\u1d436' | '\u1d437' | '\u1d438' | '\u1d439' | '\u1d43a' | '\u1d43b' | '\u1d43c' | '\u1d43d' | '\u1d43e' | '\u1d43f' | '\u1d440' | '\u1d441' | '\u1d442' | '\u1d443' | '\u1d444' | '\u1d445' | '\u1d446' | '\u1d447' | '\u1d448' | '\u1d449' | '\u1d44a' | '\u1d44b' | '\u1d44c' | '\u1d44d' | '\u1d468' | '\u1d469' | '\u1d46a' | '\u1d46b' | '\u1d46c' | '\u1d46d' | '\u1d46e' | '\u1d46f' | '\u1d470' | '\u1d471' | '\u1d472' | '\u1d473' | '\u1d474' | '\u1d475' | '\u1d476' | '\u1d477' | '\u1d478' | '\u1d479' | '\u1d47a' | '\u1d47b' | '\u1d47c' | '\u1d47d' | '\u1d47e' | '\u1d47f' | '\u1d480' | '\u1d481' | '\u1d49c' | '\u1d49e' | '\u1d49f' | '\u1d4a2' | '\u1d4a5' | '\u1d4a6' | '\u1d4a9' | '\u1d4aa' | '\u1d4ab' | '\u1d4ac' | '\u1d4ae' | '\u1d4af' | '\u1d4b0' | '\u1d4b1' | '\u1d4b2' | '\u1d4b3' | '\u1d4b4' | '\u1d4b5' | '\u1d4d0' | '\u1d4d1' | '\u1d4d2' | '\u1d4d3' | '\u1d4d4' | '\u1d4d5' | '\u1d4d6' | '\u1d4d7' | '\u1d4d8' | '\u1d4d9' | '\u1d4da' | '\u1d4db' | '\u1d4dc' | '\u1d4dd' | '\u1d4de' | '\u1d4df' | '\u1d4e0' | '\u1d4e1' | '\u1d4e2' | '\u1d4e3' | '\u1d4e4' | '\u1d4e5' | '\u1d4e6' | '\u1d4e7' | '\u1d4e8' | '\u1d4e9' | '\u1d504' | '\u1d505' | '\u1d507' | '\u1d508' | '\u1d509' | '\u1d50a' | '\u1d50d' | '\u1d50e' | '\u1d50f' | '\u1d510' | '\u1d511' | '\u1d512' | '\u1d513' | '\u1d514' | '\u1d516' | '\u1d517' | '\u1d518' | '\u1d519' | '\u1d51a' | '\u1d51b' | '\u1d51c' | '\u1d538' | '\u1d539' | '\u1d53b' | '\u1d53c' | '\u1d53d' | '\u1d53e' | '\u1d540' | '\u1d541' | '\u1d542' | '\u1d543' | '\u1d544' | '\u1d546' | '\u1d54a' | '\u1d54b' | '\u1d54c' | '\u1d54d' | '\u1d54e' | '\u1d54f' | '\u1d550' | '\u1d56c' | '\u1d56d' | '\u1d56e' | '\u1d56f' | '\u1d570' | '\u1d571' | '\u1d572' | '\u1d573' | '\u1d574' | '\u1d575' | '\u1d576' | '\u1d577' | '\u1d578' | '\u1d579' | '\u1d57a' | '\u1d57b' | '\u1d57c' | '\u1d57d' | '\u1d57e' | '\u1d57f' | '\u1d580' | '\u1d581' | '\u1d582' | '\u1d583' | '\u1d584' | '\u1d585' | '\u1d5a0' | '\u1d5a1' | '\u1d5a2' | '\u1d5a3' | '\u1d5a4' | '\u1d5a5' | '\u1d5a6' | '\u1d5a7' | '\u1d5a8' | '\u1d5a9' | '\u1d5aa' | '\u1d5ab' | '\u1d5ac' | '\u1d5ad' | '\u1d5ae' | '\u1d5af' | '\u1d5b0' | '\u1d5b1' | '\u1d5b2' | '\u1d5b3' | '\u1d5b4' | '\u1d5b5' | '\u1d5b6' | '\u1d5b7' | '\u1d5b8' | '\u1d5b9' | '\u1d5d4' | '\u1d5d5' | '\u1d5d6' | '\u1d5d7' | '\u1d5d8' | '\u1d5d9' | '\u1d5da' | '\u1d5db' | '\u1d5dc' | '\u1d5dd' | '\u1d5de' | '\u1d5df' | '\u1d5e0' | '\u1d5e1' | '\u1d5e2' | '\u1d5e3' | '\u1d5e4' | '\u1d5e5' | '\u1d5e6' | '\u1d5e7' | '\u1d5e8' | '\u1d5e9' | '\u1d5ea' | '\u1d5eb' | '\u1d5ec' | '\u1d5ed' | '\u1d608' | '\u1d609' | '\u1d60a' | '\u1d60b' | '\u1d60c' | '\u1d60d' | '\u1d60e' | '\u1d60f' | '\u1d610' | '\u1d611' | '\u1d612' | '\u1d613' | '\u1d614' | '\u1d615' | '\u1d616' | '\u1d617' | '\u1d618' | '\u1d619' | '\u1d61a' | '\u1d61b' | '\u1d61c' | '\u1d61d' | '\u1d61e' | '\u1d61f' | '\u1d620' | '\u1d621' | '\u1d63c' | '\u1d63d' | '\u1d63e' | '\u1d63f' | '\u1d640' | '\u1d641' | '\u1d642' | '\u1d643' | '\u1d644' | '\u1d645' | '\u1d646' | '\u1d647' | '\u1d648' | '\u1d649' | '\u1d64a' | '\u1d64b' | '\u1d64c' | '\u1d64d' | '\u1d64e' | '\u1d64f' | '\u1d650' | '\u1d651' | '\u1d652' | '\u1d653' | '\u1d654' | '\u1d655' | '\u1d670' | '\u1d671' | '\u1d672' | '\u1d673' | '\u1d674' | '\u1d675' | '\u1d676' | '\u1d677' | '\u1d678' | '\u1d679' | '\u1d67a' | '\u1d67b' | '\u1d67c' | '\u1d67d' | '\u1d67e' | '\u1d67f' | '\u1d680' | '\u1d681' | '\u1d682' | '\u1d683' | '\u1d684' | '\u1d685' | '\u1d686' | '\u1d687' | '\u1d688' | '\u1d689' | '\u1d6a8' | '\u1d6a9' | '\u1d6aa' | '\u1d6ab' | '\u1d6ac' | '\u1d6ad' | '\u1d6ae' | '\u1d6af' | '\u1d6b0' | '\u1d6b1' | '\u1d6b2' | '\u1d6b3' | '\u1d6b4' | '\u1d6b5' | '\u1d6b6' | '\u1d6b7' | '\u1d6b8' | '\u1d6b9' | '\u1d6ba' | '\u1d6bb' | '\u1d6bc' | '\u1d6bd' | '\u1d6be' | '\u1d6bf' | '\u1d6c0' | '\u1d6e2' | '\u1d6e3' | '\u1d6e4' | '\u1d6e5' | '\u1d6e6' | '\u1d6e7' | '\u1d6e8' | '\u1d6e9' | '\u1d6ea' | '\u1d6eb' | '\u1d6ec' | '\u1d6ed' | '\u1d6ee' | '\u1d6ef' | '\u1d6f0' | '\u1d6f1' | '\u1d6f2' | '\u1d6f3' | '\u1d6f4' | '\u1d6f5' | '\u1d6f6' | '\u1d6f7' | '\u1d6f8' | '\u1d6f9' | '\u1d6fa' | '\u1d71c' | '\u1d71d' | '\u1d71e' | '\u1d71f' | '\u1d720' | '\u1d721' | '\u1d722' | '\u1d723' | '\u1d724' | '\u1d725' | '\u1d726' | '\u1d727' | '\u1d728' | '\u1d729' | '\u1d72a' | '\u1d72b' | '\u1d72c' | '\u1d72d' | '\u1d72e' | '\u1d72f' | '\u1d730' | '\u1d731' | '\u1d732' | '\u1d733' | '\u1d734' | '\u1d756' | '\u1d757' | '\u1d758' | '\u1d759' | '\u1d75a' | '\u1d75b' | '\u1d75c' | '\u1d75d' | '\u1d75e' | '\u1d75f' | '\u1d760' | '\u1d761' | '\u1d762' | '\u1d763' | '\u1d764' | '\u1d765' | '\u1d766' | '\u1d767' | '\u1d768' | '\u1d769' | '\u1d76a' | '\u1d76b' | '\u1d76c' | '\u1d76d' | '\u1d76e' | '\u1d790' | '\u1d791' | '\u1d792' | '\u1d793' | '\u1d794' | '\u1d795' | '\u1d796' | '\u1d797' | '\u1d798' | '\u1d799' | '\u1d79a' | '\u1d79b' | '\u1d79c' | '\u1d79d' | '\u1d79e' | '\u1d79f' | '\u1d7a0' | '\u1d7a1' | '\u1d7a2' | '\u1d7a3' | '\u1d7a4' | '\u1d7a5' | '\u1d7a6' | '\u1d7a7' | '\u1d7a8' | '\u1d7ca' ;
