From: Genevieve Bastien via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Correctly using callstack-user context
Date: Wed, 13 May 2020 10:02:04 -0400
Message-ID: <bdeb584b-7c42-9e26-ce10-a1b008212541@versatic.net>
References: <CAAS9doY1Ez7N=_H6e-w9eWg0LBJp+MMasuOEmzbO0DGyLSzViA@mail.gmail.com>
 <1486835767.11198.1589286441675.JavaMail.zimbra@efficios.com>
 <CAAS9dobxi52FyWn=9zVDkMMpmZztc1Q1msdiErMKhkDEYCtqCA@mail.gmail.com>
Reply-To: Genevieve Bastien <gbastien@versatic.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2221153782573968286=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from barracuda.ebox.ca (barracuda.ebox.ca [96.127.255.19])
 by lists.lttng.org (Postfix) with ESMTPS id 49McGP7295z21tc
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 10:18:21 -0400 (EDT)
Received: from smtp.ebox.ca (smtp.ebox.ca [96.127.255.82]) by
 barracuda.ebox.ca with ESMTP id MCO6rLzHtrvLPmE4 (version=TLSv1
 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO) for <lttng-dev@lists.lttng.org>;
 Wed, 13 May 2020 10:02:04 -0400 (EDT)
Received: from [192.168.47.170] (unknown [104.163.172.174])
 by smtp.ebox.ca (Postfix) with ESMTPS id 46AEB441B21
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 10:02:04 -0400 (EDT)
In-Reply-To: <CAAS9dobxi52FyWn=9zVDkMMpmZztc1Q1msdiErMKhkDEYCtqCA@mail.gmail.com>
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
--===============2221153782573968286==
Content-Type: multipart/alternative;
 boundary="------------030E079F2CB96675849F32D4"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------030E079F2CB96675849F32D4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 5/13/20 9:42 AM, Christophe B=C3=A9dard via lttng-dev wrote:
>
> On Tue, 12 May 2020 at 08:27, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com
> <mailto:mathieu.desnoyers@efficios.com>> wrote:
>
>     How does your test program issue the system call ? Is it directly
>     with syscall() (see syscall(2) man page), or
>     does it call into libc ? Is your entire libc compiled with
>     -fno-omit-frame-pointer ?
>
>
> Indirectly, through libc/libstdc++. We use the default system libs
> (which I assume use -O, which in turn implies -fomit-frame-pointer).
> =C2=A0
>
>     As soon as one library in the chain to the system call is compiled
>     without frame pointers, this is where the
>     stack walk stops. This is usually libc.
>
>
> I see. Thanks for the information. Not sure we want to ship a custom
> libc unfortunately.
>
> Related question: how feasible would adding the callstack-user context
> to userspace=C2=A0events be? If it is feasible, is such a feature plann=
ed?

We had a very very experimental branch with it, using backtrace first,
then unwind. But it is not suggested, not performant. It's far from the
correct desired implementation, for which Mathieu could give more details=
=2E

It works, but not to be used in production. Students have used it in the
lab for some specific use case prototyping. I won't share the branch
here, but if you wish to try, let me know.

Genevi=C3=A8ve



--------------030E079F2CB96675849F32D4
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Christophe,<br>
    </p>
    <div class="moz-cite-prefix">On 5/13/20 9:42 AM, Christophe Bédard
      via lttng-dev wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAS9dobxi52FyWn=9zVDkMMpmZztc1Q1msdiErMKhkDEYCtqCA@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Tue, 12 May 2020 at
            08:27, Mathieu Desnoyers &lt;<a
              href="mailto:mathieu.desnoyers@efficios.com"
              target="_blank" moz-do-not-send="true">mathieu.desnoyers@efficios.com</a>&gt;
            wrote:</div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div>
              <div
style="font-family:arial,helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
                <div>
                  <div>How does your test program issue the system call
                    ? Is it directly with syscall() (see syscall(2) man
                    page), or<br>
                  </div>
                  <div>does it call into libc ? Is your entire libc
                    compiled with -fno-omit-frame-pointer ?</div>
                </div>
              </div>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>Indirectly, through libc/libstdc++. We use the default
            system libs (which I assume use -O, which in turn implies
            -fomit-frame-pointer).</div>
          <div> </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div
style="font-family:arial,helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
              <div>As soon as one library in the chain to the system
                call is compiled without frame pointers, this is where
                the<br>
              </div>
              <div>stack walk stops. This is usually libc.</div>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>I see. Thanks for the information. Not sure we want to
            ship a custom libc unfortunately.</div>
          <div><br>
          </div>
          <div>Related question: how feasible would adding the
            callstack-user context to userspace events be? If it is
            feasible, is such a feature planned?</div>
        </div>
      </div>
    </blockquote>
    <p>We had a very very experimental branch with it, using backtrace
      first, then unwind. But it is not suggested, not performant. It's
      far from the correct desired implementation, for which Mathieu
      could give more details.</p>
    <p> It works, but not to be used in production. Students have used
      it in the lab for some specific use case prototyping. I won't
      share the branch here, but if you wish to try, let me know.</p>
    <p>Geneviève</p>
    <p><br>
    </p>
  </body>
</html>

--------------030E079F2CB96675849F32D4--

--===============2221153782573968286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2221153782573968286==--
