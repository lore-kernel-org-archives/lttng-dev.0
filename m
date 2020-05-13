From: =?utf-8?q?Christophe_B=C3=A9dard_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Subject: Re: Correctly using callstack-user context
Date: Wed, 13 May 2020 11:34:55 -0400
Message-ID: <CAAS9dobBZRWw3WkZQrn2UGkHC1+tuS0BLmZCJxpxSQvDjG7oxg@mail.gmail.com>
References: <CAAS9doY1Ez7N=_H6e-w9eWg0LBJp+MMasuOEmzbO0DGyLSzViA@mail.gmail.com>
 <1486835767.11198.1589286441675.JavaMail.zimbra@efficios.com>
 <CAAS9dobxi52FyWn=9zVDkMMpmZztc1Q1msdiErMKhkDEYCtqCA@mail.gmail.com>
 <bdeb584b-7c42-9e26-ce10-a1b008212541@versatic.net>
Reply-To: =?UTF-8?Q?Christophe_B=C3=A9dard?= <bedard.christophe@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3767090567196571696=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by lists.lttng.org (Postfix) with ESMTPS id 49MdzT1XkDz223T
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 11:35:32 -0400 (EDT)
Received: by mail-ej1-x62c.google.com with SMTP id n17so14574590ejh.7
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 08:35:32 -0700 (PDT)
In-Reply-To: <bdeb584b-7c42-9e26-ce10-a1b008212541@versatic.net>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Genevieve Bastien <gbastien@versatic.net>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3767090567196571696==
Content-Type: multipart/alternative; boundary="000000000000973f0b05a58954e7"

--000000000000973f0b05a58954e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 May 2020 at 10:18, Genevieve Bastien via lttng-dev <
lttng-dev@lists.lttng.org> wrote:

> We had a very very experimental branch with it, using backtrace first,
> then unwind. But it is not suggested, not performant. It's far from the
> correct desired implementation, for which Mathieu could give more details=
.
>
> It works, but not to be used in production. Students have used it in the
> lab for some specific use case prototyping. I won't share the branch here=
,
> but if you wish to try, let me know.
>
> Genevi=C3=A8ve
>
Sure, I'd be interested!

--000000000000973f0b05a58954e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Wed, 13 May 2020 at 10:18, Genevieve Bastien via l=
ttng-dev &lt;<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank"=
>lttng-dev@lists.lttng.org</a>&gt; wrote:</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><div><blockquote type=3D"cite"><div dir=3D"ltr"><div =
class=3D"gmail_quote">
        </div>
      </div>
    </blockquote>
    <p>We had a very very experimental branch with it, using backtrace
      first, then unwind. But it is not suggested, not performant. It&#39;s
      far from the correct desired implementation, for which Mathieu
      could give more details.</p>
    <p> It works, but not to be used in production. Students have used
      it in the lab for some specific use case prototyping. I won&#39;t
      share the branch here, but if you wish to try, let me know.</p>
    <p>Genevi=C3=A8ve</p></div></blockquote><div>Sure, I&#39;d be intereste=
d!<br></div></div></div>

--000000000000973f0b05a58954e7--

--===============3767090567196571696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3767090567196571696==--
