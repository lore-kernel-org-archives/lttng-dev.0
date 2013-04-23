From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: kprobe timestamp
Date: Tue, 23 Apr 2013 14:40:08 -0400
Message-ID: <5176D588.5010307__15523.6707338647$1366742444$gmane$org@gmail.com>
References: <201304240050144491467@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1847466918=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UUi8W-0004UJ-8B
	for lttng-dev@lists.lttng.org; Tue, 23 Apr 2013 14:40:16 -0400
Received: by mail-qc0-f175.google.com with SMTP id j3so490895qcs.6
	for <lttng-dev@lists.lttng.org>; Tue, 23 Apr 2013 11:40:10 -0700 (PDT)
In-Reply-To: <201304240050144491467@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: OSDepend <osdepend@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============1847466918==
Content-Type: multipart/alternative;
 boundary="------------080805000508040808050506"

This is a multi-part message in MIME format.
--------------080805000508040808050506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 2013-04-23 12:50, OSDepend wrote:
> Hi guys,
> I just try to use kprobe, and get some thing like below:
>            
> java 15893 [015] 96380.588871: timer_cancel: timer=0xffff8804379d6698
>             java 15721 [010] 96380.588872: timer_cancel: timer=0xffff8800be3d6698
>             java 15893 [015] 96380.588875: timer_expire_entry: timer=0xffff8804379d6698 function=delayed_work_timer_fn now=4391194790
>             java 15721 [010] 96380.588876: timer_expire_entry: timer=0xffff8800be3d6698 function=delayed_work_timer_fn now=4391194790
> I want to know exactly about the time units of the events, such as
> 96380.588871, and 96380.588872.
> The number befor "." is second or millisecond? and  Is the number
> after "." nanoseconds or microseconds?
>
What did you use to generate this output? I don't recognize it.

Yannick

--------------080805000508040808050506
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    On 2013-04-23 12:50, OSDepend wrote:
    <blockquote cite="mid:201304240050144491467@gmail.com" type="cite">
      <meta content="text/html; charset=ISO-8859-1"
        http-equiv="Content-Type">
      <style>BLOCKQUOTE {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; MARGIN-LEFT: 2em
}
OL {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
UL {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
</style>
      <meta name="GENERATOR" content="MSHTML 9.00.8112.16470">
      <font face="Verdana" size="2">
        <div>Hi guys,</div>
        <div style="TEXT-INDENT: 2em">I just try to use kprobe, and get
          some thing like below:</div>
        <div style="TEXT-INDENT: 4em">
          <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            java&nbsp;15893&nbsp;[015]&nbsp;96380.588871:&nbsp;timer_cancel:&nbsp;timer=0xffff8804379d6698</div>
          <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;java&nbsp;15721&nbsp;[010]&nbsp;96380.588872:&nbsp;timer_cancel:&nbsp;timer=0xffff8800be3d6698</div>
          <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;java&nbsp;15893&nbsp;[015]&nbsp;96380.588875:&nbsp;timer_expire_entry:&nbsp;timer=0xffff8804379d6698&nbsp;function=delayed_work_timer_fn&nbsp;now=4391194790</div>
          <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;java&nbsp;15721&nbsp;[010]&nbsp;96380.588876:&nbsp;timer_expire_entry:&nbsp;timer=0xffff8800be3d6698&nbsp;function=delayed_work_timer_fn&nbsp;now=4391194790</div>
        </div>
        <div style="TEXT-INDENT: 2em">I want to know exactly about the
          time units of the events, such as 96380.588871, and
          96380.588872.</div>
        <div style="TEXT-INDENT: 2em">The number befor&nbsp;"." is second or
          millisecond? and&nbsp; Is the number after&nbsp;"." nanoseconds or
          microseconds?</div>
      </font><br>
    </blockquote>
    What did you use to generate this output? I don't recognize it. <br>
    <br>
    Yannick<br>
  </body>
</html>

--------------080805000508040808050506--


--===============1847466918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1847466918==--
