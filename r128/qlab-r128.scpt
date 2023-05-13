FasdUAS 1.101.10   ��   ��    k             l     ��  ��    7 1 @description Loudness Normalization of Audiocues     � 	 	 b   @ d e s c r i p t i o n   L o u d n e s s   N o r m a l i z a t i o n   o f   A u d i o c u e s   
  
 l     ��  ��      @author Florian Beck     �   *   @ a u t h o r   F l o r i a n   B e c k      l     ��  ��      @link florianbeck.de     �   *   @ l i n k   f l o r i a n b e c k . d e      l     ��  ��    !  @source Mic Pool (adapted)     �   6   @ s o u r c e   M i c   P o o l   ( a d a p t e d )      l     ��  ��      @version 2.0     �      @ v e r s i o n   2 . 0      l     ��   !��       @testedmacos 11.7.3    ! � " " (   @ t e s t e d m a c o s   1 1 . 7 . 3   # $ # l     �� % &��   %   @testedqlab 4.7    & � ' '     @ t e s t e d q l a b   4 . 7 $  ( ) ( l     �� * +��   * k e @about Loudness Normalization of Audiocues in Accordance with EBU R 128 adjusting the Master Volume.    + � , , �   @ a b o u t   L o u d n e s s   N o r m a l i z a t i o n   o f   A u d i o c u e s   i n   A c c o r d a n c e   w i t h   E B U   R   1 2 8   a d j u s t i n g   t h e   M a s t e r   V o l u m e . )  - . - l     �� / 0��   /   @separateprocess TRUE    0 � 1 1 ,   @ s e p a r a t e p r o c e s s   T R U E .  2 3 2 l     ��������  ��  ��   3  4 5 4 l     �� 6 7��   6   @changelog    7 � 8 8    @ c h a n g e l o g 5  9 : 9 l     �� ; <��   ; O I   v2.0  + initial version adopted of micpools level-playing-field script    < � = = �       v 2 . 0     +   i n i t i a l   v e r s i o n   a d o p t e d   o f   m i c p o o l s   l e v e l - p l a y i n g - f i e l d   s c r i p t :  > ? > l     ��������  ��  ��   ?  @ A @ l     �� B C��   B / ) USER DEFINED VARIABLES -----------------    C � D D R   U S E R   D E F I N E D   V A R I A B L E S   - - - - - - - - - - - - - - - - - A  E F E l     ��������  ��  ��   F  G H G l     I���� I Q      J K L J l    M N O M o    ���� &0 thereferencelevel theReferenceLevel N _ Y if global variables are given when this script is called by another, use those variables    O � P P �   i f   g l o b a l   v a r i a b l e s   a r e   g i v e n   w h e n   t h i s   s c r i p t   i s   c a l l e d   b y   a n o t h e r ,   u s e   t h o s e   v a r i a b l e s K R      ������
�� .ascrerr ****      � ****��  ��   L l    Q R S Q r     T U T m    ������ U o      ���� &0 thereferencelevel theReferenceLevel R   set desired LUFS level    S � V V .   s e t   d e s i r e d   L U F S   l e v e l��  ��   H  W X W l    Y���� Y Q     Z [ \ Z o    ���� 0 thefaderlevel thefaderLevel [ R      ������
�� .ascrerr ****      � ****��  ��   \ l    ] ^ _ ] r     ` a ` m    ����   a o      ���� 0 thefaderlevel thefaderLevel ^ m g set the master fader level to your preferred output level for cues with an LUFS at the reference level    _ � b b �   s e t   t h e   m a s t e r   f a d e r   l e v e l   t o   y o u r   p r e f e r r e d   o u t p u t   l e v e l   f o r   c u e s   w i t h   a n   L U F S   a t   t h e   r e f e r e n c e   l e v e l��  ��   X  c d c l    / e���� e Q     / f g h f o   # $���� 0 clipath cliPath g R      ������
�� .ascrerr ****      � ****��  ��   h l  , / i j k i r   , / l m l m   , - n n � o o  / u s r / l o c a l / b i n m o      ���� 0 clipath cliPath j 4 . set the path to r128x-cli (no trailing slash)    k � p p \   s e t   t h e   p a t h   t o   r 1 2 8 x - c l i   ( n o   t r a i l i n g   s l a s h )��  ��   d  q r q l     ��������  ��  ��   r  s t s l     �� u v��   u / )-------- END OF USER DEFINED VARIABLES --    v � w w R - - - - - - - -   E N D   O F   U S E R   D E F I N E D   V A R I A B L E S   - - t  x y x l     ��������  ��  ��   y  z { z l     �� | }��   | / )-- RUN SCRIPT ---------------------------    } � ~ ~ R - -   R U N   S C R I P T   - - - - - - - - - - - - - - - - - - - - - - - - - - - {   �  l     ��������  ��  ��   �  � � � l  02 ����� � O  02 � � � O   81 � � � k   ?0 � �  � � � I  ? P�� ���
�� .sysodlogaskr        TEXT � b   ? L � � � b   ? J � � � b   ? H � � � b   ? F � � � b   ? D � � � b   ? B � � � m   ? @ � � � � � � W A R N I N G :   T h i s   w i l l   c h a n g e   t h e   m a s t e r   l e v e l s   o f   a l l   s e l e c t e d   c u e s � o   @ A��
�� 
ret  � o   B C��
�� 
ret  � m   D E � � � � � p A   d i a l o g   w i l l   s i g n a l   w h e n   t h e   l e v e l   s e t t i n g   i s   c o m p l e t e . � o   F G��
�� 
ret  � o   H I��
�� 
ret  � m   J K � � � � �  P R O C E E D ?��   �  ��� � Q   Q0 � ��� � k   T' � �  � � � r   T a � � � c   T ] � � � l  T Y ����� � 1   T Y��
�� 
qSEL��  ��   � m   Y \��
�� 
list � o      ���� 0 theselected   �  � � � l  b b��������  ��  ��   �  ��� � Z   b' � ����� � ?   b o � � � l  b m ����� � I  b m�� ���
�� .corecnte****       **** � n   b i � � � 2  e i��
�� 
cobj � o   b e���� 0 theselected  ��  ��  ��   � m   m n����   � k   r# � �  � � � X   r ��� � � k   � � �  � � � l  � ���������  ��  ��   �  ��� � Z   � � ����� � =  � � � � � n   � � � � � 1   � ���
�� 
qTyp � o   � ����� 0 eachcue   � m   � � � � � � � 
 a u d i o � k   � � �  � � � l  � ���������  ��  ��   �  � � � r   � � � � � n   � � � � � 1   � ���
�� 
strq � n   � � � � � 1   � ���
�� 
psxp � l  � � ����� � c   � � � � � n   � � � � � 1   � ���
�� 
qFTr � o   � ����� 0 eachcue   � m   � ���
�� 
alis��  ��   � o      ���� &0 currentfiletarget currentFileTarget �  � � � r   � � � � � c   � � � � � l  � � ����� � I  � ��� ���
�� .sysoexecTEXT���     TEXT � b   � � � � � b   � � � � � b   � � � � � b   � � � � � b   � � � � � b   � � � � � m   � � � � � � �  e c h o   $ (   � l  � � ����� � c   � � � � � o   � ����� 0 clipath cliPath � m   � ���
�� 
TEXT��  ��   � m   � � � � � � �  / r 1 2 8 x - c l i   � l  � � ����� � c   � � � � � o   � ����� &0 currentfiletarget currentFileTarget � m   � ���
�� 
TEXT��  ��   � m   � � � � � � � `   |   t a i l   - n 1   |   a w k   ' { p r i n t   $ ( N F - 2 ) } '   |   s e d   ' s / \ . / � n   � � � � � 4   � ��� �
�� 
cha  � m   � �����  � l  � � ����� � c   � � � � � l  � � ����� � ^   � � � � � m   � �����  � m   � ����� ��  ��   � m   � ���
�� 
ctxt��  ��   � m   � � � � � � � 
 / g '   )��  ��  ��   � m   � ���
�� 
doub � o      ���� 0 thelufs theLUFS �    r   � � [   � � l  � ���� \   � � o   � ��~�~ &0 thereferencelevel theReferenceLevel o   � ��}�} 0 thelufs theLUFS��  �   o   � ��|�| 0 thefaderlevel thefaderLevel o      �{�{ 0 theadjustment   	
	 l  � ��z�z   X R set the notes of eachcue to "LUFS: " & theLUFS & ", Adjustment: " & theadjustment    � �   s e t   t h e   n o t e s   o f   e a c h c u e   t o   " L U F S :   "   &   t h e L U F S   &   " ,   A d j u s t m e n t :   "   &   t h e a d j u s t m e n t
  I  ��y
�y .QLablevsnull���     aCue o   � ��x�x 0 eachcue   �w
�w 
levR m   � ��v�v   �u
�u 
levC m   � ��t�t   �s�r
�s 
levD o   � ��q�q 0 theadjustment  �r   �p l �o�n�m�o  �n  �m  �p  ��  ��  ��  �� 0 eachcue   � o   u x�l�l 0 theselected   � �k I #�j
�j .sysodlogaskr        TEXT m   � . L e v e l   S e t t i n g   C o m p l e t e . �i
�i 
btns m   �    O K �h!�g
�h 
dflt! m  "" �##  O K�g  �k  ��  ��  ��   � R      �f�e�d
�f .ascrerr ****      � ****�e  �d  ��  ��   � 4  8 <�c$
�c 
qDoc$ m   : ;�b�b  � 5   0 5�a%�`
�a 
capp% m   2 3&& �'' & c o m . f i g u r e 5 3 . Q L a b . 4
�` kfrmID  ��  ��   � (�_( l     �^�]�\�^  �]  �\  �_       �[)*�Z�Y n�[  ) �X�W�V�U
�X .aevtoappnull  �   � ****�W &0 thereferencelevel theReferenceLevel�V 0 thefaderlevel thefaderLevel�U 0 clipath cliPath* �T+�S�R,-�Q
�T .aevtoappnull  �   � ****+ k    2..  G//  W00  c11  ��P�P  �S  �R  , �O�O 0 eachcue  - 3�N�M�L�K�J�I n�H&�G�F ��E � ��D�C�B�A�@�?�>�= ��<�;�:�9�8 ��7 � ��6�5 ��4�3�2�1�0�/�.�-�,�+�*"�)�N &0 thereferencelevel theReferenceLevel�M  �L  �K���J 0 thefaderlevel thefaderLevel�I 0 clipath cliPath
�H 
capp
�G kfrmID  
�F 
qDoc
�E 
ret 
�D .sysodlogaskr        TEXT
�C 
qSEL
�B 
list�A 0 theselected  
�@ 
cobj
�? .corecnte****       ****
�> 
kocl
�= 
qTyp
�< 
qFTr
�; 
alis
�: 
psxp
�9 
strq�8 &0 currentfiletarget currentFileTarget
�7 
TEXT
�6 
ctxt
�5 
cha 
�4 .sysoexecTEXT���     TEXT
�3 
doub�2 0 thelufs theLUFS�1 0 theadjustment  
�0 
levR
�/ 
levC
�. 
levD�- 
�, .QLablevsnull���     aCue
�+ 
btns
�* 
dflt�) �Q3 �W 
X  �E�O �W 
X  jE�O �W 
X  �E�O)���0 �*�k/ ���%�%�%�%�%�%j O �*a ,a &E` O_ a -j j � �_ [a a l kh  �a ,a   u�a ,a &a ,a ,E` Oa �a &%a %_ a &%a  %kl!a !&a "l/%a #%j $a %&E` &O�_ &�E` 'O�a (ja )ja *_ 'a + ,OPY h[OY�zOa -a .a /a 0a 1a 2 Y hW X  hUU�Z���Y  ascr  ��ޭ