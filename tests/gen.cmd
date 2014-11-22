!generic stuff i'll use all the time
!
!The format here is:
!
!  item_name <sp>#<sp> byte_offset <sp>#<sp> trigger <sp>#<sp> data_type <sp>#<sp> value|filename [ <sp>#<sp> file_seek ]
!
! where the <sp> represents one or more white spaces:  regex \s+
!
! the bang at the beginning of these lines is a comment character,
! and would not be included in an actual specification line.
! It is necessary when the '#' are used to prevent 
! interpretation as an actual specification.  If
! a value like ' # ' is required, then a concatenation
! must be used to construct the value:  e.g.
!       ' #'.' '
! to avoid interpretation as a specification delimeter.

$::DEBUG=0;
print STDERR "Debugging on\n" if $::DEBUG;

$::PN=0x03915ed3;
$::X = 1.0;

pn  # -1  # 1 # 'L' # $::PN;
pn_0 # 0 # 1 # 'C' # $P{pn}{value}&0xff
pn_1 # 1 # 1 # 'C' # ($P{pn}{value}&0xff00)>>8
pn_2 # 2 # 1 # 'C' # ($P{pn}{value}&0xff0000)>>16


frame_count  # 4  # 1 # 'L'    # $::i+500001 
channel_id   # 8  # 1 # 'C'    # $::i%3 + 1
final_marker # 30 # 1 # "A10"  # "Some ascii text..." 

!some examples...

!bit_field   # 24 # 1 # 'C'    # (1<<($::i%8))-1
calc_time    # -1 # 1 #  X     # $::t=$::i/10.0; 
time         # 16 # 1 #  'f'   # $::t

!test         # 10 # 1 #  ($::t>0.5)?'f':'A4'  # { ($::t>0.5)?$P{time}{value}*10.0:'####' }

subcom_data  # 20 # 1 #  'A8'  # subcom_file('gen.cmd',($::i*8)%1024,8);

!cond_data    # 14 # 1 # 'L'    # my $o=seek_file('ant.dat','8*$::o',4,'f','$::x>$::X'); $o;

ant_offset   # 10 # 1 # 'L' # seek_file('ant.dat','8*$::o',4,'f','$::x>=$::i/10.0')
ant_angle    # 14 # 1 # 'f' # file_lookup('ant.dat',$P{ant_offset}{value},4,'f')
ant_data     # 18 # 1 # 'f' # file_lookup('ant.dat',$P{ant_offset}{value}+4,4,'f')
unpack_angle # 22 # 1 # 'f' # grab_frame('ant_angle')*57.3
unpack_data  # 26 # 1 # 'f' # grab_frame('ant_data')*2.0

!the current test:

