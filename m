From: OSDepend <osdepend@gmail.com>
Subject: kprobe timestamp
Date: Wed, 24 Apr 2013 00:50:16 +0800
Message-ID: <201304240050144491467__38147.541791159$1366735853$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0117877749=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <osdepend@gmail.com>) id 1UUgQC-0003Ys-Rp
	for lttng-dev@lists.lttng.org; Tue, 23 Apr 2013 12:50:25 -0400
Received: by mail-pd0-f180.google.com with SMTP id u10so552517pdi.25
	for <lttng-dev@lists.lttng.org>; Tue, 23 Apr 2013 09:50:18 -0700 (PDT)
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

--===============0117877749==
Content-Type: multipart/alternative;
	boundary="=====003_Dragon152568152217_====="


This is a multi-part message in MIME format.

--=====003_Dragon152568152217_=====
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi guys,
I just try to use kprobe, and get some thing like below:
            java 15893 [015] 96380.588871: timer_cancel: timer=0xffff8804379d6698
            java 15721 [010] 96380.588872: timer_cancel: timer=0xffff8800be3d6698
            java 15893 [015] 96380.588875: timer_expire_entry: timer=0xffff8804379d6698 function=delayed_work_timer_fn now=4391194790
            java 15721 [010] 96380.588876: timer_expire_entry: timer=0xffff8800be3d6698 function=delayed_work_timer_fn now=4391194790
I want to know exactly about the time units of the events, such as 96380.588871, and 96380.588872.
The number befor "." is second or millisecond? and  Is the number after "." nanoseconds or microseconds?
I'm a little confused, please help me out!

Best,
Chen

2013-04-24



zhengchen

--=====003_Dragon152568152217_=====
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

<META name=GENERATOR content="MSHTML 9.00.8112.16470"></HEAD>
<BODY style="MARGIN: 10px"><FONT size=2 face=Verdana>
<DIV>Hi guys,</DIV>
<DIV style="TEXT-INDENT: 2em">I just try to use kprobe, and get some thing like 
below:</DIV>
<DIV style="TEXT-INDENT: 4em">
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
java&nbsp;15893&nbsp;[015]&nbsp;96380.588871:&nbsp;timer_cancel:&nbsp;timer=0xffff8804379d6698</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;java&nbsp;15721&nbsp;[010]&nbsp;96380.588872:&nbsp;timer_cancel:&nbsp;timer=0xffff8800be3d6698</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;java&nbsp;15893&nbsp;[015]&nbsp;96380.588875:&nbsp;timer_expire_entry:&nbsp;timer=0xffff8804379d6698&nbsp;function=delayed_work_timer_fn&nbsp;now=4391194790</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;java&nbsp;15721&nbsp;[010]&nbsp;96380.588876:&nbsp;timer_expire_entry:&nbsp;timer=0xffff8800be3d6698&nbsp;function=delayed_work_timer_fn&nbsp;now=4391194790</DIV></DIV>
<DIV style="TEXT-INDENT: 2em">I want to know exactly about the time units of the 
events, such as 96380.588871, and 96380.588872.</DIV>
<DIV style="TEXT-INDENT: 2em">The number befor&nbsp;"." is second or 
millisecond? and&nbsp; Is the number after&nbsp;"." nanoseconds or 
microseconds?</DIV>
<DIV style="TEXT-INDENT: 2em">I'm a little confused, please help me out!</DIV>
<DIV style="TEXT-INDENT: 2em">&nbsp;</DIV>
<DIV>Best,</DIV>
<DIV>Chen</DIV>
<DIV>&nbsp;</DIV>
<DIV align=left><FONT color=#c0c0c0>2013-04-24</FONT></DIV>
<HR style="WIDTH: 122px; HEIGHT: 2px" align=left SIZE=2>

<DIV><FONT color=#c0c0c0>zhengchen</FONT></DIV></FONT></BODY></HTML>

--=====003_Dragon152568152217_=====--



--===============0117877749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0117877749==--
