From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Documentation: document
 tracefile max size discarded event limitation
Date: Wed, 21 May 2014 16:06:52 -0400
Message-ID: <20140521200652.GC7252__13786.6189623766$1400702901$gmane$org@thessa>
References: <1400688624-28565-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1208746576=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WnCn0-0003oX-Pj
 for lttng-dev@lists.lttng.org; Wed, 21 May 2014 16:07:08 -0400
In-Reply-To: <1400688624-28565-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1208746576==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged

On 21 May (12:10:24), Mathieu Desnoyers wrote:
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: David Goulet <dgoulet@efficios.com>
> ---
>  doc/man/lttng.1                          |    2 ++
>  src/bin/lttng/commands/enable_channels.c |    2 ++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
> index ef73b06..42105c5 100644
> --- a/doc/man/lttng.1
> +++ b/doc/man/lttng.1
> @@ -442,6 +442,8 @@ Use shared buffer for the whole system (\-k only)
>  .BR "\-C, \-\-tracefile-size SIZE"
>  Maximum size of each tracefile within a stream (in bytes).
>  0 means unlimited. (default: 0)
> +Note: traces generated with this option may inaccurately report
> +discarded events as per CTF 1.8.
>  .TP
>  .BR "\-W, \-\-tracefile-count COUNT"
>  Used in conjunction with \-C option, this will limit the number of files
> diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/com=
mands/enable_channels.c
> index 55fbae6..4a1de2c 100644
> --- a/src/bin/lttng/commands/enable_channels.c
> +++ b/src/bin/lttng/commands/enable_channels.c
> @@ -136,6 +136,8 @@ static void usage(FILE *ofp)
>  	fprintf(ofp, "  -C, --tracefile-size SIZE\n");
>  	fprintf(ofp, "                           Maximum size of each tracefile=
 within a stream (in bytes). 0 means unlimited.\n");
>  	fprintf(ofp, "                               (default: %u)\n", DEFAULT_=
CHANNEL_TRACEFILE_SIZE);
> +	fprintf(ofp, "                           Note: traces generated with th=
is option may inaccurately report\n");
> +	fprintf(ofp, "                           discarded events as per CTF 1.=
8.\n");
>  	fprintf(ofp, "  -W, --tracefile-count COUNT\n");
>  	fprintf(ofp, "                           Used in conjunction with -C op=
tion, this will limit the number\n");
>  	fprintf(ofp, "                           of files created to the specif=
ied count. 0 means unlimited.\n");
> --=20
> 1.7.10.4
>=20

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTfQdcXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02gNYH/0OqhuwbRJ9ZFHEznAJAiNva
a30K3sjODVd11AupVi/drGg91CuDNW3eUO3/ZMAHjsjlP9uZZ8lYX15uFGnZoBIS
BtyMkOCPM4OsTqJ75Io2gTTbHMa7fIAA/VOuTXY/osgoBBDBpG3Lqac8AuxBuGZ0
BwbvW7ouI2mGExPFbEvI74ytot+rbYauvNrnic8uiXTvhAQjSNFZqWsZx7pqjYwr
8eQ8iW32vJmCTlWL0WLGGv91dCQ2H0adK/MYsRseo1JZCgyUT2nWHtO6ZTdNNJgo
mXnffEYP27NHU8m5RoQzN8KK4+40WRxvsIUWSiXU4Ma1oKQ8DXWWv32513JpTzY=
=0p1p
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--


--===============1208746576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1208746576==--
