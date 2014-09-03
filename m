From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tool] Fix: mi print of probe
 attributes + validation
Date: Wed, 3 Sep 2014 14:51:02 -0400
Message-ID: <20140903185102.GD1549__48736.3408240073$1409770523$gmane$org@dalia>
References: <1409259069-1165-1-git-send-email-jonathan.r.julien@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0560878819=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XPFe8-00081X-Qq
 for lttng-dev@lists.lttng.org; Wed, 03 Sep 2014 14:51:14 -0400
In-Reply-To: <1409259069-1165-1-git-send-email-jonathan.r.julien@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0560878819==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Content-Disposition: inline


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged

On 28 Aug (16:51:09), Jonathan Rajotte Julien wrote:
> Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
> ---
>  src/common/mi-lttng.c   | 37 ++++++++++++++++++++++++++++++++++++-
>  src/common/mi_lttng.xsd |  6 +++---
>  2 files changed, 39 insertions(+), 4 deletions(-)
>=20
> diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c
> index 83df149..a250546 100644
> --- a/src/common/mi-lttng.c
> +++ b/src/common/mi-lttng.c
> @@ -914,6 +914,16 @@ int mi_lttng_event_function_probe(struct mi_writer *=
writer,
>  {
>  	int ret;
> =20
> +	ret =3D mi_lttng_writer_open_element(writer, config_element_attributes);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	ret =3D mi_lttng_writer_open_element(writer, config_element_probe_attri=
butes);
> +	if (ret) {
> +		goto end;
> +	}
> +
>  	if (event->attr.probe.addr !=3D 0) {
>  		/* event probe address */
>  		ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> @@ -936,6 +946,9 @@ int mi_lttng_event_function_probe(struct mi_writer *w=
riter,
>  			goto end;
>  		}
>  	}
> +
> +	/* Close probe_attributes and attributes */
> +	ret =3D mi_lttng_close_multi_element(writer, 2);
>  end:
>  	return ret;
>  }
> @@ -944,9 +957,29 @@ LTTNG_HIDDEN
>  int mi_lttng_event_function_entry(struct mi_writer *writer,
>  		struct lttng_event *event)
>  {
> +	int ret;
> +
> +	ret =3D mi_lttng_writer_open_element(writer, config_element_attributes);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	ret =3D mi_lttng_writer_open_element(writer, config_element_probe_attri=
butes);
> +	if (ret) {
> +		goto end;
> +	}
> +
>  	/* event probe symbol_name */
> -	return mi_lttng_writer_write_element_string(writer,
> +	ret =3D mi_lttng_writer_write_element_string(writer,
>  			config_element_symbol_name, event->attr.ftrace.symbol_name);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Close function_attributes and attributes */
> +	ret =3D mi_lttng_close_multi_element(writer, 2);
> +end:
> +	return ret;
>  }
> =20
>  LTTNG_HIDDEN
> @@ -976,6 +1009,8 @@ int mi_lttng_event(struct mi_writer *writer,
>  		}
>  		break;
>  	}
> +	case LTTNG_EVENT_FUNCTION:
> +		/* Fallthrough */
>  	case LTTNG_EVENT_PROBE:
>  		ret =3D mi_lttng_event_function_probe(writer, event);
>  		break;
> diff --git a/src/common/mi_lttng.xsd b/src/common/mi_lttng.xsd
> index d2cc5d4..b115c61 100644
> --- a/src/common/mi_lttng.xsd
> +++ b/src/common/mi_lttng.xsd
> @@ -146,9 +146,9 @@ THE SOFTWARE.
>  	<!-- Maps to the lttng_event_probe_attr struct -->
>  	<xs:complexType name=3D"event_probe_attributes_type">
>  		<xs:all>
> -			<xs:element name=3D"address" type=3D"uint64_type" />
> -			<xs:element name=3D"offset" type=3D"uint64_type" />
> -			<xs:element name=3D"symbol_name" type=3D"name_type" />
> +			<xs:element name=3D"address" type=3D"uint64_type" minOccurs=3D"0" />
> +			<xs:element name=3D"offset" type=3D"uint64_type" minOccurs=3D"0" />
> +			<xs:element name=3D"symbol_name" type=3D"name_type" minOccurs=3D"0" />
>  		</xs:all>
>  	</xs:complexType>
> =20
> --=20
> 2.0.4
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJUB2MWXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02/oMH/jawsMhIZJjZOqFIj8gXJDWP
ZCA7Cl4ix3qIHF95/D+kTFhAjSJt5/+sEcDTiWRVDHbd/fosFTyjCbQ0V1jPkPCX
w6dY5l3YHbWubIL15PPgyqQFobqibQIB5N8iHcEDTqRfXYnlbuj34vx/BhQH8EIO
zSYgSXzXYzwSPyM2lj9KmISUPVeUXYJoxlCAJFZ6oZ1aF46eDwUxQ7sBrbDVQ+Ea
zP1TceYpbkzPqIK2dtJdlpnHX0ahMdgR52lVGEmOsjKx/wIiE4i4nGBZ5XTv9Adp
06io9QQzgDHSlNVsrtkTM0pgvcrdqsQhRuoJpIQuUWEgzHUsALCWGAQZ7zkVSxw=
=Zy5j
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--


--===============0560878819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0560878819==--
