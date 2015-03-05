From: Neil Bryan <Neil.Bryan@ttp.com>
Subject: LTTng 2.6.0: Corrupt metadata?
Date: Thu, 5 Mar 2015 10:50:04 +0000
Message-ID: <8369DAE2C5B8814998E89CE414A915381F6B9211__17070.9587204785$1425552685$gmane$org@IT-Mailbox3.TTPGroup.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2064734995=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Neil.Bryan@ttp.com>) id 1YTTLz-0002Au-Sn
 for lttng-dev@lists.lttng.org; Thu, 05 Mar 2015 05:50:10 -0500
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2064734995==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_8369DAE2C5B8814998E89CE414A915381F6B9211ITMailbox3TTPGr_"

--_000_8369DAE2C5B8814998E89CE414A915381F6B9211ITMailbox3TTPGr_
Content-Type: text/plain; charset="windows-1251"
Content-Transfer-Encoding: quoted-printable

Hello LTTng devs,

I am experiencing a strange problem with what I believe is corrupt metadata=
. This is seen on v2.6.0 of LTTng.

If I try and parse recovered traces using Babeltrace, it fails with a segme=
ntation fault.

nbryan@meteorubuntu-OptiPlex-7010:/data/nbryan/Meteor/altera_trace$ babeltr=
ace --help
BabelTrace Trace Viewer and Converter 1.0.0-rc1

nbryan@meteorubuntu-OptiPlex-7010:/data/nbryan/Meteor/altera_trace$ babeltr=
ace auto-20150304-091109/
Segmentation fault (core dumped)

I thought it may be worth a look at the metadata file and I observed the fo=
llowing (these are just three examples):

Environment:
env {
     hostname =3D "socfpga_cyclone5";
     domain =3D "kernel";
     sysname =3D "Linux";
     kernel_release =3D "3.10.31-ltsi-05035-g801a40f";
     kernel_version =3D "#3 SMP Tue Mar 3 17:31:45 GMT 2015";
     tracer_name =3D "lttng-modules";
     tracer_major =3D 2;
     tracer_minor =3D 6;
     tracer_patchlevel =3D 0;
};

event {
     name =3D "syscall_exit_recvmmsg";
     id =3D 921;
     stream_id =3D 0;
     fields :=3D struct {
           integer { size =3D 32; align =3D 32; signed =3D 1; encoding =3D =
none; base =3D 10; } _ret;
           integer { size =3D 32; align =3D 32; signe   W=D1u?=AD=A9)2=BE=
=C8N=B9d=99=8F=14=89n=AE    =E8=7F   =80     =08d =3D 0; encoding =3D none;=
 base =3D 16; } _mmsg;
           integer { size =3D 32; align =3D 32; signed =3D 0; encoding =3D =
none; base =3D 16; } _timeout;
     };
};

Decoded binary values:
00h,00h,00h,57h,1Dh,D1h,75h,3Fh,ADh,A9h,29h,32h,BEh,C8h,4Eh,B9h,64h,99h,8Fh=
,14h,89h,6Eh,AEh,00h,00h,00h,00h,E8h,7Fh,00h,00h,00h,80h,00h,00h,
00h,00h,00h,01h,08h

event {
     name =3D "syscall_exit_getcpu";
     id =3D 903;
     stream_id =3D 0;
     fields :=3D struct {
           integer { size =3D 32; align =3D 32; signed =3D 1; encoding =3D =
none; base =3D 10; } _ret;
           integer { size =3D 32; align =3D 32; signed =3D 0; encoding =3D =
none; base =3D 16; } _cpup;
           integer { size =3D 32; align =3D 32; signed =3D 0; encoding =3D =
none; base =3D 16; } _nodep;
           integer { size =3D 32; align =3D 32; signed =3D 0; encoding =3D =
none; base =3D   W=D1u?=AD=A9)2=BE=C8N=B9d=99=8F=14=89n=AE    =E8=7F   =80 =
    =08 16; } _tcache;
     };
};

Decoded binary values:
00h,00h,00h,57h,1Dh,D1h,75h,3Fh,ADh,A9h,29h,32h,BEh,C8h,4Eh,B9h,64h,99h,8Fh=
,14h,89h,6Eh,AEh,00h,00h,00h,00h,E8h,7Fh,00h,00h,00h,80h,00h,00h,00h,
00h,00h,01h,08h

event {
     name =3D "syscall_exit_fstatat64";
     id =3D 886;
     stream_id =3D 0;
     fields :=3D struct {
           integer { size =3D 32; align =3D 32; signed =3D 1; encoding =3D =
none; base =3D 10; } _ret;
           integer { size =3D 32; align =3D 32; signed =3D 1; encod   W=D1u=
?=AD=A9)2=BE=C8N=B9d=99=8F=14=89n=AE    =E8=7F   =80     =08ing =3D none; b=
ase =3D 10; } _dfd;
           string _filename;
           integer { size =3D 32; align =3D 32; signed =3D 0; encoding =3D =
none; base =3D 16; } _statbuf;
           integer { size =3D 32; align =3D 32; signed =3D 1; encoding =3D =
none; base =3D 10; } _flag;
     };
};

Decoded binary values:
00h,00h,00h,57h,1Dh,D1h,75h,3Fh,ADh,A9h,29h,32h,BEh,C8h,4Eh,B9h,64h,99h,8Fh=
,14h,89h,6Eh,AEh,00h,00h,00h,00h,E8h,7Fh,00h,00h,00h,80h,00h,00h,
00h,00h,00h,01h,08h

In a metadata file containing 7200 lines, I see this corruption 74 times.

I also notice that the header of the metadata file contains something very =
similar:

57h,1Dh,D1h,75h,3Fh,ADh,A9h,29h,32h,BEh,C8h,4Eh,B9h,64h,99h,8Fh,14h,89h,6Eh=
,AEh,00h,00h,00h,00h,D8h,27h,00h,00h,00h,80h,00h,00h,00h,00h,00h,01h,08h

This appears identical to the other instances, less the first three 00h byt=
es.

Now it may be intentional to squirt binary data into what is essentially  a=
 text file, but it looks suspicious. Can anyone shed any light on what is h=
appening here?
Is the metadata file supposed to have any binary data in it at all?

Thanks,

Neil.





--_000_8369DAE2C5B8814998E89CE414A915381F6B9211ITMailbox3TTPGr_
Content-Type: text/html; charset="windows-1251"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dwindows-1=
251">
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:2.0cm 42.5pt 2.0cm 3.0cm;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello LTTng devs,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am experiencing a strange problem with what I beli=
eve is corrupt metadata. This is seen on v2.6.0 of LTTng.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If I try and parse recovered traces using Babeltrace=
, it fails with a segmentation fault.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
nbryan@meteorubuntu-OptiPlex-7010:/data/nbryan/Meteor/altera_trace$ babeltr=
ace --help<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
BabelTrace Trace Viewer and Converter 1.0.0-rc1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
nbryan@meteorubuntu-OptiPlex-7010:/data/nbryan/Meteor/altera_trace$ babeltr=
ace auto-20150304-091109/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Segmentation fault (core dumped)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I thought it may be worth a look at the metadata fil=
e and I observed the following (these are just three examples):<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Environment:<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
env {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; hostname =3D &quot;socfpga_cyclone5&quot;;<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; domain =3D &quot;kernel&quot;;<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; sysname =3D &quot;Linux&quot;;<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; kernel_release =3D &quot;3.10.31-ltsi-05035-g801a4=
0f&quot;;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; kernel_version =3D &quot;#3 SMP Tue Mar 3 17:31:45=
 GMT 2015&quot;;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; tracer_name =3D &quot;lttng-modules&quot;;<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; tracer_major =3D 2;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; tracer_minor =3D 6;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; tracer_patchlevel =3D 0;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
};<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
event {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; name =3D &quot;syscall_exit_recvmmsg&quot;;<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; id =3D 921;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; stream_id =3D 0;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; fields :=3D struct {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; integer { size=
 =3D 32; align =3D 32; signed =3D 1; encoding =3D none; base =3D 10; } _ret=
;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; integer { size=
 =3D 32; align =3D 32; signe&nbsp;&nbsp; W=D1u?=AD=A9)2=BE=C8N=B9d=99=8F&#2=
0;=89n=AE&nbsp;&nbsp;&nbsp; =E8&#127;&nbsp;&nbsp; =80&nbsp;&nbsp;&nbsp;&nbs=
p; &#8;d =3D 0; encoding =3D none; base =3D 16; } _mmsg;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; integer { size=
 =3D 32; align =3D 32; signed =3D 0; encoding =3D none; base =3D 16; } _tim=
eout;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
};<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Decoded binary values:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
00h,00h,00h,57h,1Dh,D1h,75h,3Fh,ADh,A9h,29h,32h,BEh,C8h,4Eh,B9h,64h,99h,8Fh=
,14h,89h,6Eh,AEh,00h,00h,00h,00h,E8h,7Fh,00h,00h,00h,80h,00h,00h,<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
00h,00h,00h,01h,08h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
event {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; name =3D &quot;syscall_exit_getcpu&quot;;<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; id =3D 903;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; stream_id =3D 0;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; fields :=3D struct {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; integer { size=
 =3D 32; align =3D 32; signed =3D 1; encoding =3D none; base =3D 10; } _ret=
;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; integer { size=
 =3D 32; align =3D 32; signed =3D 0; encoding =3D none; base =3D 16; } _cpu=
p;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; integer { size=
 =3D 32; align =3D 32; signed =3D 0; encoding =3D none; base =3D 16; } _nod=
ep;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; integer { size=
 =3D 32; align =3D 32; signed =3D 0; encoding =3D none; base =3D&nbsp;&nbsp=
; W=D1u?=AD=A9)2=BE=C8N=B9d=99=8F&#20;=89n=AE&nbsp;&nbsp;&nbsp; =E8&#127;&n=
bsp;&nbsp; =80&nbsp;&nbsp;&nbsp;&nbsp; &#8; 16; } _tcache;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
};<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Decoded binary values:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
00h,00h,00h,57h,1Dh,D1h,75h,3Fh,ADh,A9h,29h,32h,BEh,C8h,4Eh,B9h,64h,99h,8Fh=
,14h,89h,6Eh,AEh,00h,00h,00h,00h,E8h,7Fh,00h,00h,00h,80h,00h,00h,00h,<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
00h,00h,01h,08h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
event {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; name =3D &quot;syscall_exit_fstatat64&quot;;<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; id =3D 886;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; stream_id =3D 0;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; fields :=3D struct {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; integer { size=
 =3D 32; align =3D 32; signed =3D 1; encoding =3D none; base =3D 10; } _ret=
;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; integer { size=
 =3D 32; align =3D 32; signed =3D 1; encod&nbsp;&nbsp; W=D1u?=AD=A9)2=BE=C8=
N=B9d=99=8F&#20;=89n=AE&nbsp;&nbsp;&nbsp; =E8&#127;&nbsp;&nbsp; =80&nbsp;&n=
bsp;&nbsp;&nbsp; &#8;ing =3D none; base =3D 10; } _dfd;<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; string _filena=
me;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; integer { size=
 =3D 32; align =3D 32; signed =3D 0; encoding =3D none; base =3D 16; } _sta=
tbuf;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; integer { size=
 =3D 32; align =3D 32; signed =3D 1; encoding =3D none; base =3D 10; } _fla=
g;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
};<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Decoded binary values:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
00h,00h,00h,57h,1Dh,D1h,75h,3Fh,ADh,A9h,29h,32h,BEh,C8h,4Eh,B9h,64h,99h,8Fh=
,14h,89h,6Eh,AEh,00h,00h,00h,00h,E8h,7Fh,00h,00h,00h,80h,00h,00h,<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
00h,00h,00h,01h,08h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In a metadata file containing 7200 lines, I see this=
 corruption 74 times.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I also notice that the header of the metadata file c=
ontains something very similar:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
57h,1Dh,D1h,75h,3Fh,ADh,A9h,29h,32h,BEh,C8h,4Eh,B9h,64h,99h,8Fh,14h,89h,6Eh=
,AEh,00h,00h,00h,00h,D8h,27h,00h,00h,00h,80h,00h,00h,00h,00h,00h,01h,08h<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This appears identical to the other instances, less =
the first three 00h bytes.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Now it may be intentional to squirt binary data into=
 what is essentially&nbsp; a text file, but it looks suspicious. Can anyone=
 shed any light on what is happening here?<o:p></o:p></p>
<p class=3D"MsoNormal">Is the metadata file supposed to have any binary dat=
a in it at all?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Neil.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_8369DAE2C5B8814998E89CE414A915381F6B9211ITMailbox3TTPGr_--


--===============2064734995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2064734995==--
