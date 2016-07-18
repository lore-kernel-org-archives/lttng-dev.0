From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: Re: URCU C++ wrapper?
Date: Mon, 18 Jul 2016 11:22:52 -0400
Message-ID: <578CF44C.2040907__19352.8429409072$1468855291$gmane$org@gydle.com>
References: <CACNseid7w-nSAOJvGph1P6_nGroMPHqUT_oJAp+x_Y5_MCmmgA@mail.gmail.com>
 <1617651200.73768.1468855029639.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3895218078847132616=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 1F228A3BEF
 for <lttng-dev@lists.lttng.org>; Mon, 18 Jul 2016 15:21:10 +0000 (UTC)
In-Reply-To: <1617651200.73768.1468855029639.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, noam cohen <noam1023@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============3895218078847132616==
Content-Type: multipart/alternative;
 boundary="------------020409030200070603040902"

This is a multi-part message in MIME format.
--------------020409030200070603040902
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Perhaps he wants a drop-in replacement of std::unordered_map.

On 07/18/2016 11:17 AM, Mathieu Desnoyers wrote:
>
> ----- On Jul 17, 2016, at 2:25 AM, noam cohen <noam1023@gmail.com> wrote:
>
>     Hi
>     Has anyone created a c++ wrapper to the hashtable?
>     If not, I will try to roll my own and give back as a pull request.
>
>
> There are extern "C" guards around the rculfhash.h header. This should
> allow you to use rculfhash from C++ code. Do you have something else
> in mind ?
>
> Thanks,
>
> Mathieu
>
>
>     Thanks
>     Noam C
>
>     _______________________________________________
>     lttng-dev mailing list
>     lttng-dev@lists.lttng.org
>     https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------020409030200070603040902
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Perhaps he wants a drop-in replacement of std::unordered_map.<br>
    <br>
    <div class="moz-cite-prefix">On 07/18/2016 11:17 AM, Mathieu
      Desnoyers wrote:<br>
    </div>
    <blockquote
      cite="mid:1617651200.73768.1468855029639.JavaMail.zimbra@efficios.com"
      type="cite">
      <div style="font-family: arial, helvetica, sans-serif; font-size:
        12pt; color: #000000">
        <div><br>
        </div>
        <div><span id="zwchr" data-marker="__DIVIDER__">----- On Jul 17,
            2016, at 2:25 AM, noam cohen <a class="moz-txt-link-rfc2396E" href="mailto:noam1023@gmail.com">&lt;noam1023@gmail.com&gt;</a>
            wrote:<br>
          </span></div>
        <div data-marker="__QUOTED_TEXT__">
          <blockquote style="border-left:2px solid
#1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;">
            <div dir="ltr">Hi
              <div>Has anyone created a c++ wrapper to the hashtable?</div>
              <div>If not, I will try to roll my own and give back as a
                pull request.</div>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>There are extern "C" guards around the rculfhash.h
            header. This should<br data-mce-bogus="1">
          </div>
          <div>allow you to use rculfhash from C++ code. Do you have
            something else<br data-mce-bogus="1">
          </div>
          <div>in mind ?<br data-mce-bogus="1">
          </div>
          <div><br data-mce-bogus="1">
          </div>
          <div>Thanks,<br data-mce-bogus="1">
          </div>
          <div><br data-mce-bogus="1">
          </div>
          <div>Mathieu<br data-mce-bogus="1">
          </div>
          <div><br data-mce-bogus="1">
          </div>
          <blockquote style="border-left:2px solid
#1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;">
            <div dir="ltr"><br>
              <div>Thanks</div>
              <div>Noam C</div>
            </div>
            <br>
            _______________________________________________<br>
            lttng-dev mailing list<br>
            <a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><br>
            <a class="moz-txt-link-freetext" href="https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
          </blockquote>
        </div>
        <div><br>
        </div>
        <div data-marker="__SIG_POST__">-- <br>
        </div>
        <div>Mathieu Desnoyers<br>
          EfficiOS Inc.<br>
          <a class="moz-txt-link-freetext" href="http://www.efficios.com">http://www.efficios.com</a></div>
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

--------------020409030200070603040902--

--===============3895218078847132616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3895218078847132616==--
