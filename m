From: Genevieve Bastien <gbastien@versatic.net>
Subject: Re: Mixing kernel and userspace traces in a single
 events editor view
Date: Fri, 3 Aug 2018 18:34:01 -0400
Message-ID: <2f00819a-0f8e-9412-4e05-3743a6236d06__49324.1838914857$1533335545$gmane$org@versatic.net>
References: <1533304674046.28750@BlackBox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5844288432222439055=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from barracuda.ebox.ca (barracuda.ebox.ca [96.127.255.19])
 by lists.lttng.org (Postfix) with ESMTPS id 41j20G3wSNz15Kg
 for <lttng-dev@lists.lttng.org>; Fri,  3 Aug 2018 18:34:22 -0400 (EDT)
Received: from smtp.ebox.ca (smtp.electronicbox.net [96.127.255.82]) by
 barracuda.ebox.ca with ESMTP id WfJhCD1B1yelIgL2 (version=TLSv1
 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO) for <lttng-dev@lists.lttng.org>;
 Fri, 03 Aug 2018 18:34:02 -0400 (EDT)
Received: from [192.168.69.103] (unknown [192.222.165.165])
 by smtp.ebox.ca (Postfix) with ESMTPS id 0FCAE441B21
 for <lttng-dev@lists.lttng.org>; Fri,  3 Aug 2018 18:34:02 -0400 (EDT)
In-Reply-To: <1533304674046.28750@BlackBox.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============5844288432222439055==
Content-Type: multipart/alternative;
 boundary="------------59E29207708380E66BADBFDC"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------59E29207708380E66BADBFDC
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

Hi John,


In Trace Compass, you can import/open your traces as an "experiment".
See the documentation here for more information on experiments:
http://archive.eclipse.org/tracecompass/doc/stable/org.eclipse.tracecompass.doc.user/Trace-Compass-Main-Features.html#Creating_an_Experiment


Regards,

Geneviève


On 2018-08-03 09:57 AM, John O'Sullivan wrote:
>
> Hi,
>
>
> I using trace compass on an embedded target, I have a sample
> application with some user space events and I am also collecting some
> kernel events.
>
> Is there some way in trace compass of looking at these in a single
> Events Editor view so that both kernel and Userspace events are
> interleaved with respect to time?
>
>
> The script I am using on my target is;
>
>
>  #!/bin/sh
> HOST_IP="10.xxx.xxx.xxx"
> #Create a session sending the data over the network to a listening host
> lttng create --set-url=net://$HOST_IP
> #Create one or more events
> lttng enable-event -u -a -c chan1
> lttng enable-event --kernel sched_switch,sched_process_fork
> #create an event for the logger
> lttng enable-event --kernel lttng_logger
> lttng start
> echo "Loading sample aplication" > /proc/lttng-logger
> /usr/bin/sample_application
> echo "unLoading sample aplication" > /proc/lttng-logger
> lttng destroy
>
>
> The resulting traces when opened only allows me to view kernel and UST
> on separate tabs
>
>
> regards
>
>
> John
>
>
> ------------------------------------------------------------------------
>
> This email and any files transmitted with it are confidential and are
> intended for the sole use of the individual to whom they are
> addressed. Black Box Corporation reserves the right to scan all e-mail
> traffic for restricted content and to monitor all e-mail in general.
> If you are not the intended recipient or you have received this email
> in error, any use, dissemination or forwarding of this email is
> strictly prohibited. If you have received this email in error, please
> notify the sender by replying to this email.
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------59E29207708380E66BADBFDC
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi John,</p>
    <p><br>
    </p>
    <p>In Trace Compass, you can import/open your traces as an
      "experiment". See the documentation here for more information on
      experiments:
<a class="moz-txt-link-freetext" href="http://archive.eclipse.org/tracecompass/doc/stable/org.eclipse.tracecompass.doc.user/Trace-Compass-Main-Features.html#Creating_an_Experiment">http://archive.eclipse.org/tracecompass/doc/stable/org.eclipse.tracecompass.doc.user/Trace-Compass-Main-Features.html#Creating_an_Experiment</a></p>
    <p><br>
    </p>
    <p>Regards,</p>
    <p>Geneviève<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2018-08-03 09:57 AM, John O'Sullivan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1533304674046.28750@BlackBox.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none"><!--P{margin-top:0;margin-bottom:0;} --></style>
      <p>Hi,</p>
      <p><br>
      </p>
      <p>I using trace compass on an embedded target, I have a sample
        application with some user space events and I am also collecting
        some kernel events.</p>
      <p>Is there some way in trace compass of looking at these in a
        single Events Editor view so that both kernel and Userspace
        events are interleaved with respect to time?</p>
      <p><br>
      </p>
      <p>The script I am using on my target is;</p>
      <p><br>
      </p>
      <p> #!/bin/sh<br>
        HOST_IP="10.xxx.xxx.xxx"<br>
        #Create a session sending the data over the network to a
        listening host<br>
        lttng create --set-url=net://$HOST_IP<br>
        #Create one or more events<br>
        lttng enable-event -u -a -c chan1<br>
        lttng enable-event --kernel sched_switch,sched_process_fork<br>
        #create an event for the logger<br>
        lttng enable-event --kernel lttng_logger<br>
        lttng start<br>
        echo "Loading sample aplication" &gt; /proc/lttng-logger<br>
        /usr/bin/sample_application<br>
        echo "unLoading sample aplication" &gt; /proc/lttng-logger<br>
        lttng destroy</p>
      <p><br>
      </p>
      <p>The resulting traces when opened only allows me to view kernel
        and UST on separate tabs<br>
        <br>
      </p>
      <p><br>
      </p>
      <p>regards</p>
      <p><br>
      </p>
      <p>John <br>
      </p>
      <br>
      <hr>
      <font color="Gray" size="1" face="Arial"><br>
        This email and any files transmitted with it are confidential
        and are intended for the sole use of the individual to whom they
        are addressed. Black Box Corporation reserves the right to scan
        all e-mail traffic for restricted content and to monitor all
        e-mail in general. If you are not the intended recipient or you
        have received this email in error, any use, dissemination or
        forwarding of this email is strictly prohibited. If you have
        received this email in error, please notify the sender by
        replying to this email.<br>
      </font>
      <!--'"--><br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
lttng-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>
<a class="moz-txt-link-freetext" href="https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------59E29207708380E66BADBFDC--

--===============5844288432222439055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5844288432222439055==--
