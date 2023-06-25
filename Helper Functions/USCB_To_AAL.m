function[aal] = USCB_To_AAL(uscb, aal)

%%%
% Function that maps USCBrain atlas regions to AAL atlas regions
% 
% Lore Flipts
%
% INPUT:
%   uscb: N_B*1 double matrix with map in uscbrain atlas. (N_B = #timeseries_uscb) 
%   aal: N_A*1 double matrix with map in aal atlas. (N_A = #timeseries_aal) 
%
% OUTPUT:
%   aal: N_A*1 double matrix with map in aal atlas. (N_A = #timeseries_aal)
%
%%%

aal(61) = nanmean([aal(61),uscb(1)]);
aal(62) = nanmean([aal(62),uscb(2)]);
aal(47) = nanmean([aal(47),uscb(3)]);
aal(48) = nanmean([aal(48),uscb(4)]);
aal(47) = nanmean([aal(47),uscb(5)]);
aal(48) = nanmean([aal(48),uscb(6)]);
aal(9) = nanmean([aal(9),uscb(7)]);
aal(10) = nanmean([aal(10),uscb(8)]);
aal(31) = nanmean([aal(31),uscb(9)]);
aal(32) = nanmean([aal(32),uscb(10)]);
aal(33) = nanmean([aal(33),uscb(11)]);
aal(34) = nanmean([aal(34),uscb(12)]);
aal(35) = nanmean([aal(35),uscb(13)]);
aal(36) = nanmean([aal(36),uscb(14)]);
aal(41) = nanmean([aal(41),uscb(15)]);
aal(42) = nanmean([aal(42),uscb(16)]);
aal(41) = nanmean([aal(41),uscb(17)]);
aal(42) = nanmean([aal(42),uscb(18)]);
aal(51) = nanmean([aal(51),uscb(19)]);
aal(52) = nanmean([aal(52),uscb(20)]);
aal(51) = nanmean([aal(51),uscb(21)]);
aal(52) = nanmean([aal(52),uscb(22)]);
aal(25) = nanmean([aal(25),aal(27),uscb(23)]);
aal(27) = nanmean([aal(25),aal(27),uscb(23)]);
aal(26) = nanmean([aal(26),aal(28),uscb(24)]);
aal(28) = nanmean([aal(26),aal(28),uscb(24)]);
aal(49) = nanmean([aal(49),uscb(25)]);
aal(50) = nanmean([aal(50),uscb(26)]);
aal(49) = nanmean([aal(49),uscb(27)]);
aal(50) = nanmean([aal(50),uscb(28)]);
aal(49) = nanmean([aal(49),uscb(29)]);
aal(50) = nanmean([aal(50),uscb(30)]);
aal(77) = nanmean([aal(77),uscb(31)]);
aal(78) = nanmean([aal(78),uscb(32)]);
aal(77) = nanmean([aal(77),uscb(33)]);
aal(78) = nanmean([aal(78),uscb(34)]);
aal(77) = nanmean([aal(77),uscb(35)]);
aal(78) = nanmean([aal(78),uscb(36)]);
aal(29) = nanmean([aal(29),uscb(37)]);
aal(30) = nanmean([aal(30),uscb(38)]);
aal(29) = nanmean([aal(29),uscb(39)]);
aal(30) = nanmean([aal(30),uscb(40)]);
aal(9) = nanmean([aal(9),uscb(41)]);
aal(10) = nanmean([aal(10),uscb(42)]);
aal(9) = nanmean([aal(9),uscb(43)]);
aal(10) = nanmean([aal(10),uscb(44)]);
aal(43) = nanmean([aal(43),uscb(45)]);
aal(44) = nanmean([aal(44),uscb(46)]);
aal(43) = nanmean([aal(43),uscb(47)]);
aal(44) = nanmean([aal(44),uscb(48)]);
aal(7) = nanmean([aal(7),uscb(49)]);
aal(8) = nanmean([aal(8),uscb(50)]);
aal(7) = nanmean([aal(7),uscb(51)]);
aal(8) = nanmean([aal(8),uscb(52)]);
aal(47) = nanmean([aal(47),uscb(53)]);
aal(48) = nanmean([aal(48),uscb(54)]);
aal(47) = nanmean([aal(47),uscb(55)]);
aal(48) = nanmean([aal(48),uscb(56)]);
aal(47) = nanmean([aal(47),uscb(57)]);
aal(48) = nanmean([aal(48),uscb(58)]);
aal(5) = nanmean([aal(5),uscb(59)]);
aal(6) = nanmean([aal(6),uscb(60)]);
aal(73) = nanmean([aal(73),uscb(61)]);
aal(74) = nanmean([aal(74),uscb(62)]);
aal(73) = nanmean([aal(73),uscb(63)]);
aal(74) = nanmean([aal(74),uscb(64)]);
aal(73) = nanmean([aal(73),uscb(65)]);
aal(74) = nanmean([aal(74),uscb(66)]);
aal(73) = nanmean([aal(73),uscb(67)]);
aal(74) = nanmean([aal(74),uscb(68)]);
aal(65) = nanmean([aal(65),uscb(69)]);
aal(66) = nanmean([aal(66),uscb(70)]);
aal(37) = nanmean([aal(37),uscb(71)]);
aal(38) = nanmean([aal(38),uscb(72)]);
aal(11) = nanmean([aal(11),uscb(73)]);
aal(12) = nanmean([aal(12),uscb(74)]);
aal(11) = nanmean([aal(11),uscb(75)]);
aal(12) = nanmean([aal(12),uscb(76)]);
aal(15) = nanmean([aal(15),uscb(77)]);
aal(16) = nanmean([aal(16),uscb(78)]);
aal(13) = nanmean([aal(13),uscb(79)]);
aal(14) = nanmean([aal(14),uscb(80)]);
aal(13) = nanmean([aal(13),uscb(81)]);
aal(14) = nanmean([aal(14),uscb(82)]);
aal(13) = nanmean([aal(13),uscb(83)]);
aal(14) = nanmean([aal(14),uscb(84)]);
aal(53) = nanmean([aal(53),uscb(85)]);
aal(54) = nanmean([aal(54),uscb(86)]);
aal(53) = nanmean([aal(53),uscb(87)]);
aal(54) = nanmean([aal(54),uscb(88)]);
aal(9) = nanmean([aal(9),uscb(89)]);
aal(10) = nanmean([aal(10),uscb(90)]);
aal(1) = nanmean([aal(1),uscb(91)]);
aal(2) = nanmean([aal(2),uscb(92)]);
aal(1) = nanmean([aal(1),uscb(93)]);
aal(2) = nanmean([aal(2),uscb(94)]);
aal(63) = nanmean([aal(63),uscb(95)]);
aal(64) = nanmean([aal(64),uscb(96)]);
aal(63) = nanmean([aal(63),uscb(97)]);
aal(64) = nanmean([aal(64),uscb(98)]);
aal(31) = nanmean([aal(31),uscb(99)]);
aal(32) = nanmean([aal(32),uscb(100)]);
aal(3) = nanmean([aal(3),aal(23),uscb(101)]);
aal(23) = nanmean([aal(3),aal(23),uscb(101)]);
aal(4) = nanmean([aal(4),aal(24),uscb(102)]);
aal(24) = nanmean([aal(4),aal(24),uscb(102)]);
aal(19) = nanmean([aal(19),uscb(103)]);
aal(20) = nanmean([aal(20),uscb(104)]);
aal(45) = nanmean([aal(45),uscb(105)]);
aal(46) = nanmean([aal(46),uscb(106)]);
aal(45) = nanmean([aal(45),uscb(107)]);
aal(46) = nanmean([aal(46),uscb(108)]);
aal(55) = nanmean([aal(55),uscb(109)]);
aal(56) = nanmean([aal(56),uscb(110)]);
aal(55) = nanmean([aal(55),uscb(111)]);
aal(56) = nanmean([aal(56),uscb(112)]);
aal(69) = nanmean([aal(69),uscb(113)]);
aal(70) = nanmean([aal(70),uscb(114)]);
aal(69) = nanmean([aal(69),uscb(115)]);
aal(70) = nanmean([aal(70),uscb(116)]);
aal(69) = nanmean([aal(69),uscb(117)]);
aal(70) = nanmean([aal(70),uscb(118)]);
aal(59) = nanmean([aal(59),uscb(119)]);
aal(60) = nanmean([aal(60),uscb(120)]);
aal(57) = nanmean([aal(57),uscb(121)]);
aal(58) = nanmean([aal(58),uscb(122)]);
aal(71) = nanmean([aal(71),aal(75),uscb(123)]);
aal(75) = nanmean([aal(71),aal(75),uscb(123)]);
aal(72) = nanmean([aal(72),aal(76),uscb(124)]);
aal(76) = nanmean([aal(72),aal(76),uscb(124)]);
aal(5) = nanmean([aal(5),uscb(125)]);
aal(6) = nanmean([aal(6),uscb(126)]);
aal(5) = nanmean([aal(5),uscb(127)]);
aal(6) = nanmean([aal(6),uscb(128)]);
aal(69) = nanmean([aal(69),uscb(129)]);
aal(70) = nanmean([aal(70),uscb(130)]);

end

