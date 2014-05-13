From: David Goulet <dgoulet@efficios.com>
Subject: Re: [RFC Patch Tools 3/4] Remove required parameter
 from module parameters
Date: Tue, 13 May 2014 13:47:50 -0400
Message-ID: <20140513174750.GH7414__631.972452583973$1400003348$gmane$org@thessa>
References: <cover.1396521858.git.jan.glauber@gmail.com>
 <5a25b2f118fe3069a12e292b380031364f3e9a68.1396521858.git.jan.glauber@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1049522348=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ns236805.ip-192-99-35.net ([192.99.35.19]
 helo=smtp.ini-tech.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WkGo4-0005i9-PU
 for lttng-dev@lists.lttng.org; Tue, 13 May 2014 13:48:07 -0400
In-Reply-To: <5a25b2f118fe3069a12e292b380031364f3e9a68.1396521858.git.jan.glauber@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jan Glauber <jan.glauber@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1049522348==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AzNpbZlgThVzWita"
Content-Disposition: inline


--AzNpbZlgThVzWita
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jan,

I was merging those for 2.5 but this one (3/4) does not apply. I tried
to play with it but I can't make it work.

The only thing that has changed is that we've added a module lately but
even by modifying your patch to add that module, it still does not
apply.

Do you think you can simply rebase those on upstream master and send it
back to me? (You can also send me a branch, I'm fine with emails or
branch).

Big thanks!
David

On 03 Apr (12:57:46), Jan Glauber wrote:
> Remove the per module required parameter by adding another list
> for optional core modules, so we have:
>=20
> - required core modules
> - optional core modules
> - optional probe modules
>=20
> Signed-off-by: Jan Glauber <jan.glauber@gmail.com>
> ---
>  src/bin/lttng-sessiond/kern-modules.h |    1 -
>  src/bin/lttng-sessiond/modprobe.c     |  167 ++++++++++++++++++---------=
------
>  2 files changed, 92 insertions(+), 76 deletions(-)
>=20
> diff --git a/src/bin/lttng-sessiond/kern-modules.h b/src/bin/lttng-sessio=
nd/kern-modules.h
> index 7ce8b0b..ca09fc3 100644
> --- a/src/bin/lttng-sessiond/kern-modules.h
> +++ b/src/bin/lttng-sessiond/kern-modules.h
> @@ -29,7 +29,6 @@
> =20
>  struct kern_modules_param {
>  	const char *name;
> -	int required;
>  };
> =20
>  #endif /* _KERN_MODULES_H */
> diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/m=
odprobe.c
> index ea3fb39..79a01ea 100644
> --- a/src/bin/lttng-sessiond/modprobe.c
> +++ b/src/bin/lttng-sessiond/modprobe.c
> @@ -25,65 +25,72 @@
>  #include "modprobe.h"
>  #include "kern-modules.h"
> =20
> -/* LTTng kernel tracer base modules list */
> -const struct kern_modules_param kern_modules_control[] =3D {
> -	{ "lttng-tracer", 1 },	/* MUST be loaded first so keep at top */
> -	{ "lttng-lib-ring-buffer", 1 },
> -	{ "lttng-ring-buffer-client-discard", 1 },
> -	{ "lttng-ring-buffer-client-overwrite", 1 },
> -	{ "lttng-ring-buffer-metadata-client", 1 },
> -	{ "lttng-ring-buffer-client-mmap-discard", 1 },
> -	{ "lttng-ring-buffer-client-mmap-overwrite", 1 },
> -	{ "lttng-ring-buffer-metadata-mmap-client", 1 },
> -	{ "lttng-types", 0 },
> -	{ "lttng-ftrace", 0 },
> -	{ "lttng-kprobes", 0 },
> -	{ "lttng-kretprobes", 0 },
> +#define LTTNG_MOD_REQUIRED	1
> +#define LTTNG_MOD_OPTIONAL	0
> +
> +/* LTTng kernel tracer mandatory core modules list */
> +const struct kern_modules_param kern_modules_control_core[] =3D {
> +	{ "lttng-tracer" },	/* MUST be loaded first so keep at top */
> +	{ "lttng-lib-ring-buffer" },
> +	{ "lttng-ring-buffer-client-discard" },
> +	{ "lttng-ring-buffer-client-overwrite" },
> +	{ "lttng-ring-buffer-metadata-client" },
> +	{ "lttng-ring-buffer-client-mmap-discard" },
> +	{ "lttng-ring-buffer-client-mmap-overwrite" },
> +	{ "lttng-ring-buffer-metadata-mmap-client" },
> +};
> +
> +/* LTTng kernel tracer optional base modules list */
> +const struct kern_modules_param kern_modules_control_opt[] =3D {
> +	{ "lttng-types" },
> +	{ "lttng-ftrace" },
> +	{ "lttng-kprobes" },
> +	{ "lttng-kretprobes" },
>  };
> =20
>  /* LTTng kernel tracer probe modules list */
>  const struct kern_modules_param kern_modules_probes[] =3D {
> -	{ "lttng-probe-asoc", 0 },
> -	{ "lttng-probe-block", 0 },
> -	{ "lttng-probe-btrfs", 0 },
> -	{ "lttng-probe-compaction", 0 },
> -	{ "lttng-probe-ext3", 0 },
> -	{ "lttng-probe-ext4", 0 },
> -	{ "lttng-probe-gpio", 0 },
> -	{ "lttng-probe-irq", 0 },
> -	{ "lttng-probe-jbd", 0 },
> -	{ "lttng-probe-jbd2", 0 },
> -	{ "lttng-probe-kmem", 0 },
> -	{ "lttng-probe-kvm", 0 },
> -	{ "lttng-probe-kvm-x86", 0 },
> -	{ "lttng-probe-kvm-x86-mmu", 0 },
> -	{ "lttng-probe-lock", 0 },
> -	{ "lttng-probe-module", 0 },
> -	{ "lttng-probe-napi", 0 },
> -	{ "lttng-probe-net", 0 },
> -	{ "lttng-probe-power", 0 },
> -	{ "lttng-probe-printk", 0 },
> -	{ "lttng-probe-random", 0 },
> -	{ "lttng-probe-rcu", 0 },
> -	{ "lttng-probe-regmap", 0 },
> -	{ "lttng-probe-regulator", 0 },
> -	{ "lttng-probe-rpm", 0 },
> -	{ "lttng-probe-sched", 0 },
> -	{ "lttng-probe-scsi", 0 },
> -	{ "lttng-probe-signal", 0 },
> -	{ "lttng-probe-skb", 0 },
> -	{ "lttng-probe-sock", 0 },
> -	{ "lttng-probe-statedump", 0 },
> -	{ "lttng-probe-sunrpc", 0 },
> -	{ "lttng-probe-timer", 0 },
> -	{ "lttng-probe-udp", 0 },
> -	{ "lttng-probe-vmscan", 0 },
> -	{ "lttng-probe-workqueue", 0 },
> -	{ "lttng-probe-writeback", 0 },
> +	{ "lttng-probe-asoc" },
> +	{ "lttng-probe-block" },
> +	{ "lttng-probe-btrfs" },
> +	{ "lttng-probe-compaction" },
> +	{ "lttng-probe-ext3" },
> +	{ "lttng-probe-ext4" },
> +	{ "lttng-probe-gpio" },
> +	{ "lttng-probe-irq" },
> +	{ "lttng-probe-jbd" },
> +	{ "lttng-probe-jbd2" },
> +	{ "lttng-probe-kmem" },
> +	{ "lttng-probe-kvm" },
> +	{ "lttng-probe-kvm-x86" },
> +	{ "lttng-probe-kvm-x86-mmu" },
> +	{ "lttng-probe-lock" },
> +	{ "lttng-probe-module" },
> +	{ "lttng-probe-napi" },
> +	{ "lttng-probe-net" },
> +	{ "lttng-probe-power" },
> +	{ "lttng-probe-printk" },
> +	{ "lttng-probe-random" },
> +	{ "lttng-probe-rcu" },
> +	{ "lttng-probe-regmap" },
> +	{ "lttng-probe-regulator" },
> +	{ "lttng-probe-rpm" },
> +	{ "lttng-probe-sched" },
> +	{ "lttng-probe-scsi" },
> +	{ "lttng-probe-signal" },
> +	{ "lttng-probe-skb" },
> +	{ "lttng-probe-sock" },
> +	{ "lttng-probe-statedump" },
> +	{ "lttng-probe-sunrpc" },
> +	{ "lttng-probe-timer" },
> +	{ "lttng-probe-udp" },
> +	{ "lttng-probe-vmscan" },
> +	{ "lttng-probe-workqueue" },
> +	{ "lttng-probe-writeback" },
>  };
> =20
>  void modprobe_remove_lttng(const struct kern_modules_param *modules,
> -			   int entries)
> +			   int entries, int required)
>  {
>  	int ret =3D 0, i;
>  	char modprobe[256];
> @@ -94,26 +101,21 @@ void modprobe_remove_lttng(const struct kern_modules=
_param *modules,
>  				modules[i].name);
>  		if (ret < 0) {
>  			PERROR("snprintf modprobe -r");
> -			goto error;
> +			return;
>  		}
>  		modprobe[sizeof(modprobe) - 1] =3D '\0';
>  		ret =3D system(modprobe);
>  		if (ret =3D=3D -1) {
>  			ERR("Unable to launch modprobe -r for module %s",
> -					kern_modules_control[i].name);
> -		} else if (kern_modules_control[i].required
> -				&& WEXITSTATUS(ret) !=3D 0) {
> +					modules[i].name);
> +		} else if (required && WEXITSTATUS(ret) !=3D 0) {
>  			ERR("Unable to remove module %s",
> -					kern_modules_control[i].name);
> +					modules[i].name);
>  		} else {
>  			DBG("Modprobe removal successful %s",
> -					kern_modules_control[i].name);
> +					modules[i].name);
>  		}
>  	}
> -
> -error:
> -	return;
> -
>  }
> =20
>  /*
> @@ -121,8 +123,12 @@ error:
>   */
>  void modprobe_remove_lttng_control(void)
>  {
> -	return modprobe_remove_lttng(kern_modules_control,
> -				     ARRAY_SIZE(kern_modules_control));
> +	modprobe_remove_lttng(kern_modules_control_opt,
> +				    ARRAY_SIZE(kern_modules_control_opt),
> +				    LTTNG_MOD_OPTIONAL);
> +	modprobe_remove_lttng(kern_modules_control_core,
> +				     ARRAY_SIZE(kern_modules_control_core),
> +				     LTTNG_MOD_REQUIRED);
>  }
> =20
>  /*
> @@ -131,7 +137,8 @@ void modprobe_remove_lttng_control(void)
>  void modprobe_remove_lttng_data(void)
>  {
>  	return modprobe_remove_lttng(kern_modules_probes,
> -				     ARRAY_SIZE(kern_modules_list));
> +				     ARRAY_SIZE(kern_modules_probes),
> +				     LTTNG_MOD_OPTIONAL);
>  }
> =20
>  /*
> @@ -143,7 +150,8 @@ void modprobe_remove_lttng_all(void)
>  	modprobe_remove_lttng_control();
>  }
> =20
> -static int modprobe_lttng(const struct kern_modules_param *modules, int =
entries)
> +static int modprobe_lttng(const struct kern_modules_param *modules,
> +			  int entries, int required)
>  {
>  	int ret =3D 0, i;
>  	char modprobe[256];
> @@ -151,7 +159,7 @@ static int modprobe_lttng(const struct kern_modules_p=
aram *modules, int entries)
>  	for (i =3D 0; i < entries; i++) {
>  		ret =3D snprintf(modprobe, sizeof(modprobe),
>  				"/sbin/modprobe %s%s",
> -				modules[i].required ? "" : "-q ",
> +				required ? "" : "-q ",
>  				modules[i].name);
>  		if (ret < 0) {
>  			PERROR("snprintf modprobe");
> @@ -162,12 +170,10 @@ static int modprobe_lttng(const struct kern_modules=
_param *modules, int entries)
>  		if (ret =3D=3D -1) {
>  			ERR("Unable to launch modprobe for module %s",
>  					modules[i].name);
> -		} else if (modules[i].required && WEXITSTATUS(ret) !=3D 0) {
> -			ERR("Unable to load module %s",
> -					modules[i].name);
> +		} else if (required && WEXITSTATUS(ret) !=3D 0) {
> +			ERR("Unable to load module %s", modules[i].name);
>  		} else {
> -			DBG("Modprobe successfully %s",
> -					modules[i].name);
> +			DBG("Modprobe successfully %s", modules[i].name);
>  		}
>  	}
> =20
> @@ -180,14 +186,25 @@ error:
>   */
>  int modprobe_lttng_control(void)
>  {
> -	return modprobe_lttng(kern_modules_control,
> -			      ARRAY_SIZE(kern_modules_control));
> +	int ret;
> +
> +	ret =3D modprobe_lttng(kern_modules_control_core,
> +			     ARRAY_SIZE(kern_modules_control_core),
> +			     LTTNG_MOD_REQUIRED);
> +	if (ret !=3D 0)
> +		return ret;
> +	ret =3D modprobe_lttng(kern_modules_control_opt,
> +			      ARRAY_SIZE(kern_modules_control_opt),
> +			      LTTNG_MOD_OPTIONAL);
> +	return ret;
>  }
> +
>  /*
>   * Load data kernel module(s).
>   */
>  int modprobe_lttng_data(void)
>  {
>  	return modprobe_lttng(kern_modules_probes,
> -			      ARRAY_SIZE(kern_modules_probes));
> +			      ARRAY_SIZE(kern_modules_probes),
> +			      LTTNG_MOD_OPTIONAL);
>  }
> --=20
> 1.7.9.5
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--AzNpbZlgThVzWita
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTclrGXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02OwAH/iYxy0MKpLjwuW1gMYFRUf7g
1tT22xy7+xs5W1RiV0NQ9/3uIvC6Mw7gRPu+RKkXP5lBPEqO77Qyvs9LwlVRY3w5
WfC3vzDl3QlpjO8ceYb/1Xzs26tu9z1vTSmlUl6zt+V7DWmo/dpVYPavEOT84ju5
cVIUsFBuK7/KlLqgEfI8LmF4jWZO2GdeF9sl/SfP2pgY2XzLgACiXDrWmXZw42lF
U8QPuFHIvR7iHj9FcRaXcesdzdFrUzYkFIz6kTTUcWajrLGy3dXQRhp3GxJsgsIB
yIEMSLkoSFsPV0piaFCyVZF7vISGB+zZZxvtUlizHqpGW0deN7X3CY5lLC3Q7PY=
=t06N
-----END PGP SIGNATURE-----

--AzNpbZlgThVzWita--


--===============1049522348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1049522348==--
