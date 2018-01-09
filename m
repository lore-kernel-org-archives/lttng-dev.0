From: Genevieve Bastien <gbastien+lttng@versatic.net>
Subject: Re: LD_PRELOAD applications using lttng-ust-pthread
Date: Tue, 9 Jan 2018 10:34:18 -0500
Message-ID: <bfd757ed-4b3e-1294-f476-34a2b373acac__26022.1254350201$1515513077$gmane$org@versatic.net>
References: <CACbQsw8qxK=8sFZqUs_9KL_bRy+-bTY70PE3kKHEMeSyZHmjaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6273203851888130711=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from s056.panelboxmanager.com (s056.panelboxmanager.com
 [174.142.230.146])
 by lists.lttng.org (Postfix) with ESMTPS id 3zGGrL0zGTznk3
 for <lttng-dev@lists.lttng.org>; Tue,  9 Jan 2018 15:53:05 +0000 (UTC)
Received: from mailnull by s056.panelboxmanager.com with sa-checked (Exim 4.89)
 (envelope-from <gbastien+lttng@versatic.net>) id 1eYvut-002KWS-Dj
 for lttng-dev@lists.lttng.org; Tue, 09 Jan 2018 10:34:19 -0500
Received: from station16.dorsal.polymtl.ca ([132.207.72.9]:40994)
 by s056.panelboxmanager.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 (envelope-from <gbastien+lttng@versatic.net>) id 1eYvut-002KWA-4J
 for lttng-dev@lists.lttng.org; Tue, 09 Jan 2018 10:34:19 -0500
In-Reply-To: <CACbQsw8qxK=8sFZqUs_9KL_bRy+-bTY70PE3kKHEMeSyZHmjaA@mail.gmail.com>
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
--===============6273203851888130711==
Content-Type: multipart/alternative;
 boundary="------------B00FE249738D0D134A981E60"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------B00FE249738D0D134A981E60
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Majid,


See the documentation here:
http://lttng.org/docs/v2.10/#doc-using-lttng-ust-with-daemons and
http://lttng.org/docs/v2.10/#doc-liblttng-ust-fd. Firefox requires at
least one of those extra libraries to be preloaded, the one for fork I
think.


I recall trying to trace firefox with lttng-cyg-profile without much
success. Without the liblttng-ust-fork.so preloaded, my tabs had
segfaults. But when I tried with both libraries, it seemed there was a
conflict between cyg-profile and the other preloaded libraries, I don't
remember exactly what happened. Maybe you won't have this problem with
lttng-ust-libc-wrapper.


I hope this helps,

Geneviève


On 2018-01-08 10:35 PM, Majid Rezazadeh wrote:
> Hi all
>
> I am using lttng-ust-libc-wrapper for instrumenting some calls to libc
> for some applications like Firefox and Chrome, but I receive
> "Segmentation fault (core dumped)". I compile lttng-ust-pthread.c (gcc
> -fPIC -shared  -o test.so lttng-ust-pthread.c -ldl) and then I use
> "LD_PRELOAD=test.so firefox" but I receive segmentation fault (I have
> exported LD_LIBRARY_PATH to the absolute path of test.so file). I
> found out that when I replace tracepoints with printf in
> lttng_ust_pthread.c, I receive no error. It seems that hooking
> tracepoints in this wrapper makes some problems. Do you have any idea
> in this regard?
>
> Thanks
>
> Majid
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------B00FE249738D0D134A981E60
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Majid,</p>
    <p><br>
    </p>
    <p>See the documentation here:
      <a class="moz-txt-link-freetext" href="http://lttng.org/docs/v2.10/#doc-using-lttng-ust-with-daemons">http://lttng.org/docs/v2.10/#doc-using-lttng-ust-with-daemons</a> and
      <a class="moz-txt-link-freetext" href="http://lttng.org/docs/v2.10/#doc-liblttng-ust-fd">http://lttng.org/docs/v2.10/#doc-liblttng-ust-fd</a>. Firefox requires
      at least one of those extra libraries to be preloaded, the one for
      fork I think. <br>
    </p>
    <p><br>
    </p>
    <p>I recall trying to trace firefox with lttng-cyg-profile without
      much success. Without the liblttng-ust-fork.so preloaded, my tabs
      had segfaults. But when I tried with both libraries, it seemed
      there was a conflict between cyg-profile and the other preloaded
      libraries, I don't remember exactly what happened. Maybe you won't
      have this problem with lttng-ust-libc-wrapper.<br>
    </p>
    <p><br>
    </p>
    <p>I hope this helps,</p>
    <p>Geneviève<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2018-01-08 10:35 PM, Majid Rezazadeh
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CACbQsw8qxK=8sFZqUs_9KL_bRy+-bTY70PE3kKHEMeSyZHmjaA@mail.gmail.com">
      <div dir="ltr"><span style="font-size:12.8px">Hi all</span><br>
        <br>
        <span style="font-size:12.8px">I am using lttng-ust-libc-wr</span><font
          face="arial, helvetica, sans-serif">apper <span style="color:rgb(36,41,46);white-space:pre-wrap">for instrumenting</span> </font><span style="color:rgb(36,41,46);white-space:pre-wrap"><font face="arial, helvetica, sans-serif">some calls to libc for </font></span><font
          face="arial, helvetica, sans-serif">som<span
            style="font-size:12.8px">e applica</span></font><span
          style="font-size:12.8px">tions like Firefox and Chrome, but I
          receive "Segmentation fault (core dumped)". I compile
          lttng-ust-pthread.c (gcc -fPIC -shared  -o test.so
          lttng-ust-pthread.c -ldl) and then I use "LD_PRELOAD=test.so
          firefox" but I receive segmentation fault (I have exported
          LD_LIBRARY_PATH to the absolute path of test.so file). I found
          out that when I replace tracepoints with printf in
          lttng_ust_pthread.c, I receive no error. It seems that hooking
          tracepoints in this wrapper makes some problems. Do you have
          any idea in this regard?</span><br>
        <div>
          <div style="font-size:12.8px"><br>
          </div>
          <div style="font-size:12.8px"><span style="font-size:12.8px"><font
                color="#000000">Thanks<br>
                <br>
              </font></span></div>
        </div>
        <div style="font-size:12.8px"><span style="font-size:12.8px"><font
              color="#000000">Majid</font></span></div>
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

--------------B00FE249738D0D134A981E60--

--===============6273203851888130711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6273203851888130711==--
