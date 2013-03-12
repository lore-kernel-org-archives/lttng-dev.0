From: OSDepend <osdepend@gmail.com>
Subject: build error: ltt-control package
Date: Wed, 13 Mar 2013 01:25:21 +0800
Message-ID: <201303130125186687389__49539.1642129563$1363109181$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0386815613=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-da0-f42.google.com ([209.85.210.42])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <osdepend@gmail.com>) id 1UFSx9-0001Xm-5E
	for lttng-dev@lists.lttng.org; Tue, 12 Mar 2013 13:25:31 -0400
Received: by mail-da0-f42.google.com with SMTP id n15so26708dad.29
	for <lttng-dev@lists.lttng.org>; Tue, 12 Mar 2013 10:25:26 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


This is a multi-part message in MIME format.

--===============0386815613==
Content-Type: multipart/alternative;
	boundary="=====003_Dragon516327333577_====="


This is a multi-part message in MIME format.

--=====003_Dragon516327333577_=====
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, all,

I met some trouble when i tried to "make" the ltt-control-0.88-09242010. The code is list below:

make[2]: Leaving directory `/usr/src/ltt-control-0.88-09242010/liblttd'
Making all in lttd
make[2]: Entering directory `/usr/src/ltt-control-0.88-09242010/lttd'
gcc -DHAVE_CONFIG_H -I.. -I..     -g -O2 -MT lttd.o -MD -MP -MF .deps/lttd.Tpo -c -o lttd.o lttd.c
mv -f .deps/lttd.Tpo .deps/lttd.Po
/bin/sh ../libtool --tag=CC   --mode=link gcc  -g -O2   -o lttd lttd.o ../liblttd/liblttd.la -lpthread
libtool: link: gcc -g -O2 -o .libs/lttd lttd.o  ../liblttd/.libs/liblttd.so -lpthread
../liblttd/.libs/liblttd.so: undefined reference to `sync_file_range'
collect2: ld returned 1 exit status
make[2]: *** [lttd] Error 1
make[2]: Leaving directory `/usr/src/ltt-control-0.88-09242010/lttd'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/usr/src/ltt-control-0.88-09242010'
make: *** [all] Error 2

My workstation is Centos 5.5, glibc-2.5.
It seems like a design bug in centos which ignore the sysycall sync_file_range, so seems the only way for me is to just delete the related code.
Is there any other way to make it through? please help me out!!

2013-03-13



zhengchen

--=====003_Dragon516327333577_=====
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content="text/html; charset=us-ascii" http-equiv=Content-Type>
<STYLE>BLOCKQUOTE {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; MARGIN-LEFT: 2em
}
OL {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
UL {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
</STYLE>

<META name=GENERATOR content="MSHTML 9.00.8112.16457"></HEAD>
<BODY style="MARGIN: 10px"><FONT size=2 face=Verdana>
<DIV>Hi, all,</DIV>
<DIV>&nbsp;</DIV>
<DIV style="TEXT-INDENT: 2em">I met some trouble when i tried to "make" the 
ltt-control-0.88-09242010. The code is list below:</DIV>
<DIV style="TEXT-INDENT: 2em">&nbsp;</DIV>
<DIV style="TEXT-INDENT: 2em">
<DIV>make[2]:&nbsp;Leaving&nbsp;directory&nbsp;`/usr/src/ltt-control-0.88-09242010/liblttd'</DIV>
<DIV>Making&nbsp;all&nbsp;in&nbsp;lttd</DIV>
<DIV>make[2]:&nbsp;Entering&nbsp;directory&nbsp;`/usr/src/ltt-control-0.88-09242010/lttd'</DIV>
<DIV>gcc&nbsp;-DHAVE_CONFIG_H&nbsp;-I..&nbsp;-I..&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-g&nbsp;-O2&nbsp;-MT&nbsp;lttd.o&nbsp;-MD&nbsp;-MP&nbsp;-MF&nbsp;.deps/lttd.Tpo&nbsp;-c&nbsp;-o&nbsp;lttd.o&nbsp;lttd.c</DIV>
<DIV>mv&nbsp;-f&nbsp;.deps/lttd.Tpo&nbsp;.deps/lttd.Po</DIV>
<DIV>/bin/sh&nbsp;../libtool&nbsp;--tag=CC&nbsp;&nbsp;&nbsp;--mode=link&nbsp;gcc&nbsp;&nbsp;-g&nbsp;-O2&nbsp;&nbsp;&nbsp;-o&nbsp;lttd&nbsp;lttd.o&nbsp;../liblttd/liblttd.la&nbsp;-lpthread</DIV>
<DIV>libtool:&nbsp;link:&nbsp;gcc&nbsp;-g&nbsp;-O2&nbsp;-o&nbsp;.libs/lttd&nbsp;lttd.o&nbsp;&nbsp;../liblttd/.libs/liblttd.so&nbsp;-lpthread</DIV>
<DIV><STRONG>../liblttd/.libs/liblttd.so:&nbsp;undefined&nbsp;reference&nbsp;to&nbsp;`sync_file_range'</STRONG></DIV>
<DIV>collect2:&nbsp;ld&nbsp;returned&nbsp;1&nbsp;exit&nbsp;status</DIV>
<DIV>make[2]:&nbsp;***&nbsp;[lttd]&nbsp;Error&nbsp;1</DIV>
<DIV>make[2]:&nbsp;Leaving&nbsp;directory&nbsp;`/usr/src/ltt-control-0.88-09242010/lttd'</DIV>
<DIV>make[1]:&nbsp;***&nbsp;[all-recursive]&nbsp;Error&nbsp;1</DIV>
<DIV>make[1]:&nbsp;Leaving&nbsp;directory&nbsp;`/usr/src/ltt-control-0.88-09242010'</DIV>
<DIV>make:&nbsp;***&nbsp;[all]&nbsp;Error&nbsp;2</DIV>
<DIV>&nbsp;</DIV>
<DIV>My workstation is Centos 5.5, glibc-2.5.</DIV>
<DIV>It seems like a design bug in centos which ignore the sysycall 
<STRONG>sync_file_range</STRONG>, so seems the only way for me is to just delete 
the related code.</DIV>
<DIV>Is there any other way to make it through? please help me out!!</DIV></DIV>
<DIV>&nbsp;</DIV>
<DIV align=left><FONT color=#c0c0c0>2013-03-13</FONT></DIV>
<HR style="WIDTH: 122px; HEIGHT: 2px" align=left SIZE=2>

<DIV><FONT color=#c0c0c0>zhengchen</FONT></DIV></FONT></BODY></HTML>

--=====003_Dragon516327333577_=====--



--===============0386815613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0386815613==--
