From: Genevieve Bastien <gbastien+lttng@versatic.net>
Subject: Re: CTF -> Chrome Trace Event
Date: Wed, 1 Nov 2017 11:57:08 -0400
Message-ID: <9ea71b68-d929-b284-afff-8109df8225d4__20353.4350767315$1509553804$gmane$org@versatic.net>
References: <CADwgpi9pwMp_wWAEjtpvcGEx6R2wifaHABZjgmQD9QUGufa1AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0666745286378779035=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from s056.panelboxmanager.com (s056.panelboxmanager.com
 [174.142.230.146])
 by lists.lttng.org (Postfix) with ESMTPS id 3yRtwV4y6yztBy
 for <lttng-dev@lists.lttng.org>; Wed,  1 Nov 2017 16:29:46 +0000 (UTC)
Received: from mailnull by s056.panelboxmanager.com with sa-checked (Exim 4.89)
 (envelope-from <gbastien+lttng@versatic.net>) id 1e9vOA-003gxC-HR
 for lttng-dev@lists.lttng.org; Wed, 01 Nov 2017 11:57:11 -0400
Received: from [132.207.72.9] (port=51666)
 by s056.panelboxmanager.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 (envelope-from <gbastien+lttng@versatic.net>) id 1e9vO9-003gwk-8H
 for lttng-dev@lists.lttng.org; Wed, 01 Nov 2017 11:57:09 -0400
In-Reply-To: <CADwgpi9pwMp_wWAEjtpvcGEx6R2wifaHABZjgmQD9QUGufa1AA@mail.gmail.com>
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
--===============0666745286378779035==
Content-Type: multipart/alternative;
 boundary="------------35F11F4FDC803B8AA5FEA233"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------35F11F4FDC803B8AA5FEA233
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Alok,


I don't know about anyone converting CTF to Catapult trace events, (it
would probably be rather straightforward to do with babeltrace 2 if you
know how to translate the events correctly) but in the Trace Compass
Incubator, we do have support for the trace-event format, so that Trace
Compass can read both CTF and trace-event traces.


See here [1] for instructions to install Incubator features and install
the "Trace Compass TraceEvent Parser" feature. You'll get some of the
catapult analyses with it.


[1]
http://versatic.net/tracecompass/incubator/2017/09/13/introducing-tracecompass-incubator.html


Cheers,

Geneviève


On 2017-10-31 07:33 PM, Alok Priyadarshi wrote:
> Hello,
>
> I am considering using lttng in my current project. We also like
> Catapult <https://github.com/catapult-project/catapult> trace viewer
> used by chrome://tracing.
>
> I am wondering if someone has tried translating CTF tracepoints into
> Catapult trace events, whose format is described
> here: https://docs.google.com/document/d/1CvAClvFfyA5R-PhYUmn5OOQtYMH4h6I0nSsKchNAySU/preview
>
> Thanks in advance.
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------35F11F4FDC803B8AA5FEA233
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Alok,</p>
    <p><br>
    </p>
    <p>I don't know about anyone converting CTF to Catapult trace
      events, (it would probably be rather straightforward to do with
      babeltrace 2 if you know how to translate the events correctly)
      but in the Trace Compass Incubator, we do have support for the
      trace-event format, so that Trace Compass can read both CTF and
      trace-event traces.</p>
    <p><br>
    </p>
    <p>See here [1] for instructions to install Incubator features and
      install the "Trace Compass TraceEvent Parser" feature. You'll get
      some of the catapult analyses with it.<br>
    </p>
    <p><br>
    </p>
    <p>[1]
<a class="moz-txt-link-freetext" href="http://versatic.net/tracecompass/incubator/2017/09/13/introducing-tracecompass-incubator.html">http://versatic.net/tracecompass/incubator/2017/09/13/introducing-tracecompass-incubator.html</a></p>
    <p><br>
    </p>
    <p>Cheers,</p>
    <p>Geneviève<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2017-10-31 07:33 PM, Alok
      Priyadarshi wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CADwgpi9pwMp_wWAEjtpvcGEx6R2wifaHABZjgmQD9QUGufa1AA@mail.gmail.com">
      <div dir="ltr">Hello,
        <div><br>
        </div>
        <div>I am considering using lttng in my current project. We also
          like <a href="https://github.com/catapult-project/catapult"
            moz-do-not-send="true">Catapult</a> trace viewer used by <a
            href="chrome://tracing" moz-do-not-send="true">chrome://tracing</a>.</div>
        <div><br>
        </div>
        <div>I am wondering if someone has tried translating CTF
          tracepoints into Catapult trace events, whose format is
          described here: <a
href="https://docs.google.com/document/d/1CvAClvFfyA5R-PhYUmn5OOQtYMH4h6I0nSsKchNAySU/preview"
            moz-do-not-send="true">https://docs.google.com/document/d/1CvAClvFfyA5R-PhYUmn5OOQtYMH4h6I0nSsKchNAySU/preview</a></div>
        <div><br>
        </div>
        <div>Thanks in advance.</div>
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

--------------35F11F4FDC803B8AA5FEA233--

--===============0666745286378779035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0666745286378779035==--
