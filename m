From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [Babeltrace RFC PATCH 12/28] Add MinGW
 implementation of localtime_r
Date: Mon, 13 May 2013 16:20:51 -0400
Message-ID: <CA+jJMxu9-xae2yJhdy4FsTn9xOzbOZ6qbnECJh1q_OL0FpxbsA__47300.2683524557$1368476501$gmane$org@mail.gmail.com>
References: <009B25148989C6458484484699278506E537E8E9@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f169.google.com ([74.125.82.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UbzEv-0001GV-Kw
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 16:20:57 -0400
Received: by mail-we0-f169.google.com with SMTP id x54so6795342wes.0
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 13:20:51 -0700 (PDT)
In-Reply-To: <009B25148989C6458484484699278506E537E8E9@EU-MBX-01.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, May 2, 2013 at 7:53 AM, Ikaheimonen, JP
<jp_ikaheimonen@mentor.com> wrote:
> ---
>  include/babeltrace/compat/time.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/babeltrace/compat/time.h b/include/babeltrace/compat=
/time.h
> index ccfc860..d5cb7fd 100644
> --- a/include/babeltrace/compat/time.h
> +++ b/include/babeltrace/compat/time.h
> @@ -15,5 +15,13 @@ struct tm *gmtime_r(const time_t *timep, struct tm *re=
sult)
>         return result;
>  }
>
> +static inline
> +struct tm *localtime_r(const time_t *timep, struct tm *result)
> +{
> +       struct tm * r;
> +       r =3D localtime(timep);
> +       memcpy(result, r, sizeof (struct tm));
> +       return result;
> +}

Why not use localtime_s?

>  #endif
>  #endif
> --
> 1.8.1.msysgit.1
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
