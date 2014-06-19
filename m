From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Add vpid,
 vppid and vtid explanation in add-context help menu
Date: Thu, 19 Jun 2014 14:21:19 -0400
Message-ID: <20140619182119.GA27213__7875.82588750428$1403202149$gmane$org@thessa>
References: <1403144380-26702-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0455415024=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1Wxgxi-0001HB-B1
 for lttng-dev@lists.lttng.org; Thu, 19 Jun 2014 14:21:32 -0400
In-Reply-To: <1403144380-26702-1-git-send-email-francis.deslauriers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: francis.deslauriers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0455415024==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18 Jun (22:19:40), francis.deslauriers@efficios.com wrote:
> From: Francis Deslauriers <francis.deslauriers@efficios.com>
>=20
> Signed-off-by: Francis Deslauriers <francis.deslauriers@efficios.com>
> ---
>  src/bin/lttng/commands/add_context.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/src/bin/lttng/commands/add_context.c b/src/bin/lttng/command=
s/add_context.c
> index 405b782..52d0db4 100644
> --- a/src/bin/lttng/commands/add_context.c
> +++ b/src/bin/lttng/commands/add_context.c
> @@ -514,6 +514,9 @@ static void usage(FILE *ofp)
>  	fprintf(ofp, "                           TYPE can be one of the strings=
 below:\n");
>  	print_ctx_type(ofp);
>  	fprintf(ofp, "\n");
> +	fprintf(ofp, "Note that the vpid, vppid and vtid context types represen=
t the virtual process id,\n"
> +			"virtual parent process id and virtual thread id as seen from the cur=
rent execution context\n"
> +			"as oppose to the pid, ppid and tid that are kernel internal data str=
uctures.\n\n");

That would be kind of neat if you could also add this to the man page.
Usually, I try to keep both the --help and man page in sync :).

Cheers!
David

>  	fprintf(ofp, "Example:\n");
>  	fprintf(ofp, "This command will add the context information 'prio' and =
two per-cpu\n"
>  			"perf counters (hardware branch misses and cache misses), to all chan=
nels\n"
> --=20
> 1.8.3.2
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJToyofXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02Z7sIAKM6O4bX8T5Mo7T9GX0rEfsG
MGGMERrSnn/0WGFh3WeCQTH3THLW1zgIOHjhIIqMrVwJa5oobh0Dsnqr8zEufIeQ
srEzWCxg6ItmuCQswj/8Ijwb8KcEApJu01ItIZOnSaemF6b3x5ACf+goSFNXDgM4
hbmb3m5+c/hhcVXMAOQfZJ0SVLHjT6x7wWaojVVTxS5a514AUHMgrOGscKPl2xnq
lnWjtRU62VaFT68nddV2i2vnd7BQ7XQRNonIkLeB2PCBM+4FVjgq3YpG9zJAaKJk
H0LrQgrSj1XEFTw/m2rqvCu7Pn9l1m6WHGQz9KAGXkAvnuexxIQ3UUA6RqHFwuM=
=KC9y
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--


--===============0455415024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0455415024==--
