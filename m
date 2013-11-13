From: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Subject: Re: [lttng-tools PATCH] checkpatch: change status of
 warning from "BRACES" to "BRACES_SINGLE_STMT"
Date: Wed, 13 Nov 2013 00:47:01 -0500
Message-ID: <CAE_Gge2gApvf-+RmhPeDuD3vEvu4LM6R1OfxGvVPc1Ns3aD6PQ__15691.5509528064$1384321684$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <nashii@gmail.com>) id 1VgTIU-0007tu-JT
	for lttng-dev@lists.lttng.org; Wed, 13 Nov 2013 00:47:27 -0500
Received: by mail-ob0-f181.google.com with SMTP id uz6so5920243obc.12
	for <lttng-dev@lists.lttng.org>; Tue, 12 Nov 2013 21:47:21 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Forgot to add "lttng-tools" in the subject prefix, sorry.


2013/11/13 Rapha=EBl Beamonte <raphael.beamonte@gmail.com>
>
> The warning about braces that are not necessary for any arm of a statement
> should be interpreted as a warning about braces around single statements.
>
> Signed-off-by: Rapha=EBl Beamonte <raphael.beamonte@gmail.com>
> ---
>  extras/checkpatch.pl |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/extras/checkpatch.pl b/extras/checkpatch.pl
> index fdd8484..5a67704 100755
> --- a/extras/checkpatch.pl
> +++ b/extras/checkpatch.pl
> @@ -3138,7 +3138,7 @@ sub process {
>                                                 $sum_allowed +=3D $_;
>                                         }
>                                         if ($sum_allowed =3D=3D 0) {
> -                                               WARN("BRACES",
> +                                               WARN("BRACES_SINGLE_STMT",
>                                                      "braces {} are not n=
ecessary for any arm of this statement\n" . $herectx);
>                                         } elsif ($sum_allowed !=3D $allow=
 &&
>                                                  $seen !=3D $allow) {
> --
> 1.7.10.4
>
