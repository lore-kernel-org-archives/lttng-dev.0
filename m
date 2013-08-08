From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re:
 =?iso-8859-1?q?/home/admin/lttng-modules-2=2E3=2E0-rc?=
 =?iso-8859-1?q?1/lttng-events=2Ec=3A388=3A_error=3A_too_many_arguments_to?=
 =?iso-8859-1?q?_function_=E2tracepoint=5Fprobe=5Fregister=E2?=
Date: Thu, 08 Aug 2013 08:45:58 -0400
Message-ID: <52039306.1070306__32850.5512596623$1375966018$gmane$org@gmail.com>
References: <CAFa-mVWYapQuAYkrvTLUBdGibRugYXKBi5+dgkNwqDCTj1yvrQ@mail.gmail.com>
	<CAFa-mVUWH29L0V-OXD8UaMgdH96tcxqNd1fgxOT=YX4b7cnzGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1853200934=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1V7PbV-0007ry-FH
	for lttng-dev@lists.lttng.org; Thu, 08 Aug 2013 08:46:13 -0400
Received: by mail-qa0-f48.google.com with SMTP id o19so260267qap.14
	for <lttng-dev@lists.lttng.org>; Thu, 08 Aug 2013 05:46:04 -0700 (PDT)
In-Reply-To: <CAFa-mVUWH29L0V-OXD8UaMgdH96tcxqNd1fgxOT=YX4b7cnzGQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Suraj Bagad <surajbagad@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============1853200934==
Content-Type: multipart/alternative;
 boundary="------------080903010107040303040605"

This is a multi-part message in MIME format.
--------------080903010107040303040605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id r78CkMEJ000415

On 2013-08-08 08:35, Suraj Bagad wrote:
> HI Iam trying to install lttng-modules for kernel probing on CentOS
> 6.4 2.6.32-358.6.1.el6.x86_64
> iam getting error while running make as follows.
> /home/admin/lttng-modules-2.3.0-rc1/lttng-events.c:388: error: too
> many arguments to function =E2tracepoint_probe_register=E2
>
> I have already installed lttng-tools (lttng-tools-2.0.4-2.el6.x86_
> 64
> ) for user space probing
>
> It seems that the lttng-modules are not compatible for above mentioned
> centOS .
> Can u please let me know which version or how i can install
> lttng-modules for kernel probing for my
> mentioned CentOS version
hi,

For this version of CentOS, you need to apply some patches to the
kernel. See the linux-patches directory in the lttng-modules source tree.

Yannick

>
>
> On Thu, Aug 8, 2013 at 5:02 PM, Suraj Bagad <surajbagad@gmail.com
> <mailto:surajbagad@gmail.com>> wrote:
>
>     HI Iam trying to install lttng-modules for kernel probing on
>     CentOS 6.4 2.6.32-358.6.1.el6.x86_64
>     iam getting error while running make as follows.
>     /home/admin/lttng-modules-2.3.0-rc1/lttng-events.c:388: error: too
>     many arguments to function =E2tracepoint_probe_register=E2
>
>     I have already installed lttng-tools (lttng-tools-2.0.4-2.el6.x86_6=
4
>     ) for user space probing
>
>     It seems that the lttng-modules are not compatible for above
>     mentioned centOS .
>     Can u please let me know which version or how i can install
>     lttng-modules for kernel probing for my
>     mentioned CentOS version
>     --=20
>     Thanks
>     and Regards,
>     Suraj Bagad
>
>
>
>
> --=20
> Thanks
> and Regards
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------080903010107040303040605
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 2013-08-08 08:35, Suraj Bagad wrote:<br>
    </div>
    <blockquote
cite="mid:CAFa-mVUWH29L0V-OXD8UaMgdH96tcxqNd1fgxOT=YX4b7cnzGQ@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div>HI Iam trying to install lttng-modules for kernel probing
          on CentOS 6.4 2.6.32-358.6.1.el6.x86_64<br>
        </div>
        <div>iam getting error while running make as follows. <br>
          /home/admin/lttng-modules-2.3.0-rc1/lttng-events.c:388: error:
          too many arguments to function &acirc;tracepoint_probe_register&acirc;<br>
          <br>
        </div>
        I have already installed lttng-tools
        (lttng-tools-2.0.4-2.el6.x86_
        <div dir="ltr">64<br>
          ) for user space probing<br clear="all">
          <div>
            <div><br>
            </div>
            <div>It seems that the lttng-modules are not compatible for
              above mentioned centOS .<br>
              Can u please let me know which version or how i can
              install lttng-modules for kernel probing for my <br>
            </div>
            <div>mentioned CentOS version</div>
          </div>
        </div>
      </div>
    </blockquote>
    hi, <br>
    <br>
    For this version of CentOS, you need to apply some patches to the
    kernel. See the linux-patches directory in the lttng-modules source
    tree. <br>
    <br>
    Yannick<br>
    <br>
    <blockquote
cite="mid:CAFa-mVUWH29L0V-OXD8UaMgdH96tcxqNd1fgxOT=YX4b7cnzGQ@mail.gmail.com"
      type="cite">
      <div class="gmail_extra"><br>
        <br>
        <div class="gmail_quote">
          On Thu, Aug 8, 2013 at 5:02 PM, Suraj Bagad <span dir="ltr">&lt;<a
              moz-do-not-send="true" href="mailto:surajbagad@gmail.com"
              target="_blank">surajbagad@gmail.com</a>&gt;</span> wrote:<br>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div dir="ltr">
              <div>HI Iam trying to install lttng-modules for kernel
                probing on CentOS 6.4 2.6.32-358.6.1.el6.x86_64<br>
              </div>
              <div>iam getting error while running make as follows. <br>
                /home/admin/lttng-modules-2.3.0-rc1/lttng-events.c:388:
                error: too many arguments to function
                &acirc;tracepoint_probe_register&acirc;<br>
                <br>
              </div>
              I have already installed lttng-tools
              (lttng-tools-2.0.4-2.el6.x86_64<br>
              ) for user space probing<br clear="all">
              <div>
                <div><br>
                </div>
                <div>It seems that the lttng-modules are not compatible
                  for above mentioned centOS .<br>
                  Can u please let me know which version or how i can
                  install lttng-modules for kernel probing for my <br>
                </div>
                <div>mentioned CentOS version<span class="HOEnZb"><font
                      color="#888888"><br>
                    </font></span></div>
                <span class="HOEnZb"><font color="#888888">
                    <div>
                      -- <br>
                      Thanks <br>
                      and Regards,<br>
                    </div>
                    <div>Suraj Bagad<br>
                    </div>
                  </font></span></div>
            </div>
          </blockquote>
        </div>
        <br>
        <br clear="all">
        <br>
        -- <br>
        Thanks <br>
        and Regards
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
lttng-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>
<a class="moz-txt-link-freetext" href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------080903010107040303040605--


--===============1853200934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1853200934==--
