From: Mohamad Gebai <mgebai@suse.de>
Subject: Re: LTTng Time Stamp Issue
Date: Fri, 20 Apr 2018 16:53:02 -0400
Message-ID: <f1311a1d-33d4-4ae0-f9e8-1de1f7f552ed__386.319406288926$1524258108$gmane$org@suse.de>
References: <BY2PR0501MB21035DCCC28AFAD0D12C0587E3B40@BY2PR0501MB2103.namprd05.prod.outlook.com>
 <CA+jJMxvKyCt4VZ6U0gLu1KGA3S==CPTkTTGErOfXgBgms68xRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7193664677535030515=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by lists.lttng.org (Postfix) with ESMTPS id 40SSy84hPwz14pc
 for <lttng-dev@lists.lttng.org>; Fri, 20 Apr 2018 17:03:44 -0400 (EDT)
In-Reply-To: <CA+jJMxvKyCt4VZ6U0gLu1KGA3S==CPTkTTGErOfXgBgms68xRg@mail.gmail.com>
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
To: =?UTF-8?Q?J=c3=a9r=c3=a9mie_Galarneau?= <jeremie.galarneau@efficios.com>, Sai Tujala <Sai.Tujala@mathworks.in>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============7193664677535030515==
Content-Type: multipart/alternative;
 boundary="------------D7D4A428A62FE9E81C44850B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------D7D4A428A62FE9E81C44850B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

LTTng uses the monotonic clock [1] to timestamp the event at trace-time.
The monotonic clock is more appropriate than the real time
(CLOCK_REALTIME) when you want to timestamp/compare/order certain events
within the same system relatively to each other. Using the real time
clock would cause a problem if say someone (or something, like ntp, or
kvm in a VM) changed the system's time while tracing.

With that being said, the monotonic clock doesn't give you a time that
is very meaningful as a human (its reference is the system boot). Having
the timestamps as an actual date and time would be more interesting.
LTTng stores the real time at the beginning of the trace and stores it
in the metadata, which is later used to convert the timestamps from
monotonic time to real time. If you change the system's real time while
tracing, it won't have any effect on the timestamps of the recorded events.

Mohamad

[1] https://linux.die.net/man/3/clock_gettime
[2] http://linuxmogeb.blogspot.ca/2013/10/how-does-clockgettime-work.html


On 04/20/2018 11:37 AM, Jérémie Galarneau wrote:
> Hi,
>
> I'm adding the LTTng mailing list in CC for the benefit of the
> community and so people add to or correct my explanation.
>
> The CTF specification describes the meaning of those fields:
> http://diamon.org/ctf/#spec8
>
> In your case, this means that the timestamps in the trace are
> expressed relative to an arbitrary time set 1524226572435601778 clock
> ticks after 00:00:00 on 1 January 1970.
>
> To take your specific example:
> Your clock is running at 1,000,000,000 Hz, meaning the duration of a
> clock tick (period) is of 1 ns.
>
> The event has occurred at
> 1524226572435601778 (offset) + 00000003827855360941 (event clock
> value) nanoseconds after UNIX Epoch. That leads us to around Friday,
> April 20, 2018 1:20:00 PM (GMT).
>
> Regards,
> Jérémie
>
>
>
> On 20 April 2018 at 11:06, Sai Tujala <Sai.Tujala@mathworks.in
> <mailto:Sai.Tujala@mathworks.in>> wrote:
>
>     Hi Jeremie,
>
>      
>
>                     In metadata file of LTTng trace session,  offset
>     from Epoch is “1524226572435601778” and time stamp of an event in
>     channel data files is starting from “00000003827855360941”. Can
>     you brief about relevance between these two time stamps.
>
>      
>
>     freq = 1000000000; /* Frequency, in Hz */
>
>             /* clock value offset from Epoch is: offset * (1/freq) */
>
>             offset = 1524226572435601778;
>
>      
>
>      
>
>     Thanks & Regards,
>
>     T Sai Kiran
>
>      
>
>
>
>
> -- 
> Jérémie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------D7D4A428A62FE9E81C44850B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    LTTng uses the monotonic clock [1] to timestamp the event at
    trace-time. The monotonic clock is more appropriate than the real
    time (CLOCK_REALTIME) when you want to timestamp/compare/order
    certain events within the same system relatively to each other.
    Using the real time clock would cause a problem if say someone (or
    something, like ntp, or kvm in a VM) changed the system's time while
    tracing.<br>
    <br>
    With that being said, the monotonic clock doesn't give you a time
    that is very meaningful as a human (its reference is the system
    boot). Having the timestamps as an actual date and time would be
    more interesting. LTTng stores the real time at the beginning of the
    trace and stores it in the metadata, which is later used to convert
    the timestamps from monotonic time to real time. If you change the
    system's real time while tracing, it won't have any effect on the
    timestamps of the recorded events.<br>
    <br>
    Mohamad<br>
    <br>
    [1] <a class="moz-txt-link-freetext" href="https://linux.die.net/man/3/clock_gettime">https://linux.die.net/man/3/clock_gettime</a><br>
    [2]
    <a class="moz-txt-link-freetext" href="http://linuxmogeb.blogspot.ca/2013/10/how-does-clockgettime-work.html">http://linuxmogeb.blogspot.ca/2013/10/how-does-clockgettime-work.html</a><br>
    <br>
    <br>
    <div class="moz-cite-prefix">On 04/20/2018 11:37 AM, Jérémie
      Galarneau wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CA+jJMxvKyCt4VZ6U0gLu1KGA3S==CPTkTTGErOfXgBgms68xRg@mail.gmail.com">
      <div dir="ltr">
        <div>
          <div>
            <div>
              <div>
                <div>
                  <div>Hi,<br>
                    <br>
                  </div>
                  <div>I'm adding the LTTng mailing list in CC for the
                    benefit of the community and so people add to or
                    correct my explanation.<br>
                  </div>
                  <div><br>
                    The CTF specification describes the meaning of those
                    fields:<br>
                    <a href="http://diamon.org/ctf/#spec8"
                      moz-do-not-send="true">http://diamon.org/ctf/#spec8</a><br>
                    <br>
                  </div>
                  In your case, this means that the timestamps in the
                  trace are expressed relative to an arbitrary time set
                  1524226572435601778 clock ticks after 00:00:00 on 1
                  January 1970.<br>
                  <br>
                </div>
                To take your specific example:<br>
              </div>
              Your clock is running at 1,000,000,000 Hz, meaning the
              duration of a clock tick (period) is of 1 ns.<br>
              <br>
            </div>
            The event has occurred at<br>
          </div>
          1524226572435601778 (offset) + 00000003827855360941 (event
          clock value) nanoseconds after UNIX Epoch. That leads us to
          around Friday, April 20, 2018 1:20:00 PM (GMT).<br>
          <br>
        </div>
        <div>Regards,<br>
        </div>
        Jérémie<br>
        <div><br>
          <div>
            <div>
              <div>
                <div><br>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="gmail_extra"><br>
        <div class="gmail_quote">On 20 April 2018 at 11:06, Sai Tujala <span
            dir="ltr">&lt;<a href="mailto:Sai.Tujala@mathworks.in"
              target="_blank" moz-do-not-send="true">Sai.Tujala@mathworks.in</a>&gt;</span>
          wrote:<br>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div link="#0563C1" vlink="#954F72" lang="EN-US">
              <div class="m_-293747052095318529WordSection1">
                <p class="MsoNormal">Hi Jeremie,</p>
                <p class="MsoNormal"> </p>
                <p class="MsoNormal">                In metadata file of
                  LTTng trace session,  offset from Epoch is
                  “1524226572435601778” and time stamp of an event in
                  channel data files is starting from
                  “00000003827855360941”. Can you brief about relevance
                  between these two time stamps. </p>
                <p class="MsoNormal"> </p>
                <p class="MsoNormal" style="text-indent:.5in">freq =
                  1000000000; /* Frequency, in Hz */</p>
                <p class="MsoNormal">        /* clock value offset from
                  Epoch is: offset * (1/freq) */</p>
                <p class="MsoNormal">        offset =
                  1524226572435601778;</p>
                <p class="MsoNormal"> </p>
                <p class="MsoNormal"> </p>
                <p class="MsoNormal">Thanks &amp; Regards,</p>
                <p class="MsoNormal">T Sai Kiran</p>
                <p class="MsoNormal"> </p>
              </div>
            </div>
          </blockquote>
        </div>
        <br>
        <br clear="all">
        <br>
        -- <br>
        <div class="gmail_signature" data-smartmail="gmail_signature">Jérémie
          Galarneau<br>
          EfficiOS Inc.<br>
          <a href="http://www.efficios.com" target="_blank"
            moz-do-not-send="true">http://www.efficios.com</a></div>
      </div>
      <br>
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

--------------D7D4A428A62FE9E81C44850B--

--===============7193664677535030515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7193664677535030515==--
