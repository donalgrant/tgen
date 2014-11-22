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
$::PRF=sub { 420.0+$::T/10.0; }

pn           # 0  # 1 # 'L'    # $::PN;
frame_count  # 4  # 1 # 'L'    # $::I+500001 
channel_id   # 8  # 1 # 'C'    # $::I%3 + 1
final_marker # 30 # 1 # "A10"  # "Some ascii text..." 

!some examples...

!bit_field   # 24 # 1 # 'C'    # (1<<($::I%8))-1
!calc_time    # -1 # 1 #  X     # $::T=$::I/10.0; 
!time         # 16 # 1 #  'f'   # $::T
!
!test-me      # -1 # 1 # X      # my $prf=&$::PRF; print STDERR "prf=$prf\n";
!
!!test         # 10 # 1 #  ($::T>0.5)?'f':'A4'  # { ($::T>0.5)?$P{time}{value}*10.0:'####' }
!
!subcom_data  # 20 # 1 #  'A8'  # subcom_file('gen.cmd',($::I*8)%1024,8);
!
!ant_offset   # 10 # 1 # 'L'    # seek_file('ant.dat','8*$::O',4,'f','$::X>=$::I/10.0')
!ant_angle    # 14 # 1 # 'f'    # file_lookup('ant.dat',$P{ant_offset}{value},4,'f')
!ant_data     # 18 # 1 # 'f'    # file_lookup('ant.dat',$P{ant_offset}{value}+4,4,'f')
!unpack_angle # 22 # 1 # 'f'    # grab_frame('ant_angle')*57.3
!unpack_data  # 26 # 1 # 'f'    # grab_frame('ant_data')*2.0

!the current test:

