From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: memory leak when UST
 events are enabled with exclusions
Date: Tue, 4 Feb 2014 14:14:09 -0500
Message-ID: <20140204191409.GG13440__7244.44267475537$1391541382$gmane$org@thessa>
References: <1390240272-16029-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1644689923=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WAlRp-0000uI-JW
	for lttng-dev@lists.lttng.org; Tue, 04 Feb 2014 14:14:23 -0500
In-Reply-To: <1390240272-16029-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1644689923==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HB4mHL4PVvkpZAgW"
Content-Disposition: inline


--HB4mHL4PVvkpZAgW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 20 Jan (12:51:12), J=E9r=E9mie Galarneau wrote:
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  src/bin/lttng-sessiond/trace-ust.c | 1 +
>  src/bin/lttng-sessiond/trace-ust.h | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/=
trace-ust.c
> index 70b3a91..c08246a 100644
> --- a/src/bin/lttng-sessiond/trace-ust.c
> +++ b/src/bin/lttng-sessiond/trace-ust.c
> @@ -504,6 +504,7 @@ void trace_ust_destroy_event(struct ltt_ust_event *ev=
ent)
> =20
>  	DBG2("Trace destroy UST event %s", event->attr.name);
>  	free(event->filter);
> +	free(event->exclusion);
>  	free(event);
>  }
> =20
> diff --git a/src/bin/lttng-sessiond/trace-ust.h b/src/bin/lttng-sessiond/=
trace-ust.h
> index f2f8c7e..07af0f1 100644
> --- a/src/bin/lttng-sessiond/trace-ust.h
> +++ b/src/bin/lttng-sessiond/trace-ust.h
> @@ -50,7 +50,7 @@ struct ltt_ust_event {
>  	struct lttng_ust_event attr;
>  	struct lttng_ht_node_str node;
>  	struct lttng_ust_filter_bytecode *filter;
> -	const struct lttng_event_exclusion *exclusion;
> +	struct lttng_event_exclusion *exclusion;
>  };
> =20
>  /* UST channel */
> --=20
> 1.8.5.2
>=20

--HB4mHL4PVvkpZAgW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJS8TwBXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02y+gH/RQ0pxkpduefQrZpd18ihgMX
Do8PlzCNKvHtMtVJOe0OZqromTv9yM6ywMNDVjX8yLRgCqw/IZ33QR13eSGFFhQ+
i4kF740v/idAwxBVinwZj2Rp/GFeX6/ai4fcjJbJlbJlp6v780Db+Z5yIqeNSW9w
DEB4CkxYbywbkbpBBxbZRMDU8kpgxfsNyuVfv5QxgqXoXMk6b3RO0tNrIrn2AdhF
85nD8ygXIROSq9zzVkHSQ4ot9PAz1RWnwMwGlb5ZM0uHblN+8vgOKAU8KWbBcEq6
YfgkLL9y28S1K9n9sB5qL9UjlxvPfZvv08mZFFLNZ8Dhk8+nmVAk7ehMzMR7qyY=
=TnA/
-----END PGP SIGNATURE-----

--HB4mHL4PVvkpZAgW--


--===============1644689923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1644689923==--
