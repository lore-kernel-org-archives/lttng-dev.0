From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Update comments regarding the
 requirement of power of 2 for sub-buffer size
Date: Mon, 13 Jul 2015 11:22:54 -0400
Message-ID: <CA+jJMxtBLZymgDVMLs1hrpZ52uTnxUwCYaS1WxkKyDO-8c9tmA__22672.1902996816$1436801045$gmane$org@mail.gmail.com>
References: <1436565002-15575-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2090780132=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZEfZM-0008LM-0e
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 11:23:03 -0400
Received: by pdjr16 with SMTP id r16so64522380pdj.3
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jul 2015 08:22:54 -0700 (PDT)
In-Reply-To: <1436565002-15575-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============2090780132==
Content-Type: multipart/alternative; boundary=047d7b10ccd3b2cb5b051ac34bb0

--047d7b10ccd3b2cb5b051ac34bb0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged in master, stable-2.6 and stable-2.5.

Thanks!
J=C3=A9r=C3=A9mie

On Fri, Jul 10, 2015 at 5:50 PM, Jonathan Rajotte <
jonathan.rajotte-julien@efficios.com> wrote:

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  include/lttng/channel.h                | 2 +-
>  src/bin/lttng-sessiond/lttng-ust-abi.h | 2 +-
>  src/bin/lttng-sessiond/lttng-ust-ctl.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/lttng/channel.h b/include/lttng/channel.h
> index 6ab0c7b..2007d06 100644
> --- a/include/lttng/channel.h
> +++ b/include/lttng/channel.h
> @@ -33,7 +33,7 @@ extern "C" {
>  #define LTTNG_CHANNEL_ATTR_PADDING1        LTTNG_SYMBOL_NAME_LEN + 12
>  struct lttng_channel_attr {
>         int overwrite;                      /* 1: overwrite, 0: discard *=
/
> -       uint64_t subbuf_size;               /* bytes */
> +       uint64_t subbuf_size;               /* bytes power of 2 */
>         uint64_t num_subbuf;                /* power of 2 */
>         unsigned int switch_timer_interval; /* usec */
>         unsigned int read_timer_interval;   /* usec */
> diff --git a/src/bin/lttng-sessiond/lttng-ust-abi.h
> b/src/bin/lttng-sessiond/lttng-ust-abi.h
> index 81b6149..ae3ac22 100644
> --- a/src/bin/lttng-sessiond/lttng-ust-abi.h
> +++ b/src/bin/lttng-sessiond/lttng-ust-abi.h
> @@ -166,7 +166,7 @@ struct lttng_ust_context {
>   */
>  #define LTTNG_UST_CHANNEL_ATTR_PADDING (LTTNG_UST_SYM_NAME_LEN + 32)
>  struct lttng_ust_channel_attr {
> -       uint64_t subbuf_size;                   /* bytes */
> +       uint64_t subbuf_size;                   /* bytes power of 2 */
>         uint64_t num_subbuf;                    /* power of 2 */
>         int overwrite;                          /* 1: overwrite, 0:
> discard */
>         unsigned int switch_timer_interval;     /* usec */
> diff --git a/src/bin/lttng-sessiond/lttng-ust-ctl.h
> b/src/bin/lttng-sessiond/lttng-ust-ctl.h
> index 7f59b86..0bb717e 100644
> --- a/src/bin/lttng-sessiond/lttng-ust-ctl.h
> +++ b/src/bin/lttng-sessiond/lttng-ust-ctl.h
> @@ -45,7 +45,7 @@ struct lttng_ust_lib_ring_buffer;
>
>  struct ustctl_consumer_channel_attr {
>         enum lttng_ust_chan_type type;
> -       uint64_t subbuf_size;                   /* bytes */
> +       uint64_t subbuf_size;                   /* bytes power of 2 */
>         uint64_t num_subbuf;                    /* power of 2 */
>         int overwrite;                          /* 1: overwrite, 0:
> discard */
>         unsigned int switch_timer_interval;     /* usec */
> --
> 2.1.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7b10ccd3b2cb5b051ac34bb0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged in master, stable-2.6 and stable-2.5.<div><br></div=
><div>Thanks!</div><div>J=C3=A9r=C3=A9mie</div></div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Fri, Jul 10, 2015 at 5:50 PM, Jonath=
an Rajotte <span dir=3D"ltr">&lt;<a href=3D"mailto:jonathan.rajotte-julien@=
efficios.com" target=3D"_blank">jonathan.rajotte-julien@efficios.com</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">Signed-off-by: Jonathan R=
ajotte &lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com">jonathan=
.rajotte-julien@efficios.com</a>&gt;<br>
---<br>
=C2=A0include/lttng/channel.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 2 +-<br>
=C2=A0src/bin/lttng-sessiond/lttng-ust-abi.h | 2 +-<br>
=C2=A0src/bin/lttng-sessiond/lttng-ust-ctl.h | 2 +-<br>
=C2=A03 files changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/include/lttng/channel.h b/include/lttng/channel.h<br>
index 6ab0c7b..2007d06 100644<br>
--- a/include/lttng/channel.h<br>
+++ b/include/lttng/channel.h<br>
@@ -33,7 +33,7 @@ extern &quot;C&quot; {<br>
=C2=A0#define LTTNG_CHANNEL_ATTR_PADDING1=C2=A0 =C2=A0 =C2=A0 =C2=A0 LTTNG_=
SYMBOL_NAME_LEN + 12<br>
=C2=A0struct lttng_channel_attr {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int overwrite;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 1: overwrite, 0: discard *=
/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t subbuf_size;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* bytes */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t subbuf_size;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* bytes power of 2 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t num_subbuf;=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* power of 2 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int switch_timer_interval; /* usec */<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int read_timer_interval;=C2=A0 =C2=A0/=
* usec */<br>
diff --git a/src/bin/lttng-sessiond/lttng-ust-abi.h b/src/bin/lttng-session=
d/lttng-ust-abi.h<br>
index 81b6149..ae3ac22 100644<br>
--- a/src/bin/lttng-sessiond/lttng-ust-abi.h<br>
+++ b/src/bin/lttng-sessiond/lttng-ust-abi.h<br>
@@ -166,7 +166,7 @@ struct lttng_ust_context {<br>
=C2=A0 */<br>
=C2=A0#define LTTNG_UST_CHANNEL_ATTR_PADDING (LTTNG_UST_SYM_NAME_LEN + 32)<=
br>
=C2=A0struct lttng_ust_channel_attr {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t subbuf_size;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* bytes */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t subbuf_size;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* bytes power of 2 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t num_subbuf;=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* power of 2 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int overwrite;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 1: overwrite=
, 0: discard */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int switch_timer_interval;=C2=A0 =C2=
=A0 =C2=A0/* usec */<br>
diff --git a/src/bin/lttng-sessiond/lttng-ust-ctl.h b/src/bin/lttng-session=
d/lttng-ust-ctl.h<br>
index 7f59b86..0bb717e 100644<br>
--- a/src/bin/lttng-sessiond/lttng-ust-ctl.h<br>
+++ b/src/bin/lttng-sessiond/lttng-ust-ctl.h<br>
@@ -45,7 +45,7 @@ struct lttng_ust_lib_ring_buffer;<br>
<br>
=C2=A0struct ustctl_consumer_channel_attr {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enum lttng_ust_chan_type type;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t subbuf_size;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* bytes */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t subbuf_size;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* bytes power of 2 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t num_subbuf;=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* power of 2 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int overwrite;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 1: overwrite=
, 0: discard */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int switch_timer_interval;=C2=A0 =C2=
=A0 =C2=A0/* usec */<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--047d7b10ccd3b2cb5b051ac34bb0--


--===============2090780132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2090780132==--
