From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] utils: Rework
 utils_parse_size_suffix
Date: Mon, 14 Apr 2014 10:44:16 -0400
Message-ID: <20140414144416.GA431__4230.7993084707$1397486733$gmane$org@thessa>
References: <1397143819-4563-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1562804341=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WZi7Y-0001bH-Gq
 for lttng-dev@lists.lttng.org; Mon, 14 Apr 2014 10:44:34 -0400
In-Reply-To: <1397143819-4563-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1562804341==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged Thanks.

David

On 10 Apr (11:30:19), Simon Marchi wrote:
> Ok, so there are a lot of problems with this function (sorry :|). Taking
> the regex road is probably to complicated for nothing, so here is a
> version without regexes.
>=20
> I added many test cases as suggested by Sandeep Chaudhary and Daniel
> Thibault. I tested on both Intel 32 and 64 bits.
>=20
> Would fix #633
>=20
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  src/common/utils.c                        | 136 +++++++++++++-----------=
------
>  src/common/utils.h                        |   2 +-
>  tests/unit/test_utils_parse_size_suffix.c |  54 +++++++++++-
>  3 files changed, 111 insertions(+), 81 deletions(-)
>=20
> diff --git a/src/common/utils.c b/src/common/utils.c
> index 31596dd..9326080 100644
> --- a/src/common/utils.c
> +++ b/src/common/utils.c
> @@ -28,7 +28,6 @@
>  #include <sys/types.h>
>  #include <unistd.h>
>  #include <inttypes.h>
> -#include <regex.h>
>  #include <grp.h>
>  #include <pwd.h>
> =20
> @@ -650,42 +649,10 @@ error:
>  	return ret;
>  }
> =20
> -/**
> - * Prints the error message corresponding to a regex error code.
> - *
> - * @param errcode	The error code.
> - * @param regex		The regex object that produced the error code.
> - */
> -static void regex_print_error(int errcode, regex_t *regex)
> -{
> -	/* Get length of error message and allocate accordingly */
> -	size_t length;
> -	char *buffer;
> -
> -	assert(regex !=3D NULL);
> -
> -	length =3D regerror(errcode, regex, NULL, 0);
> -	if (length =3D=3D 0) {
> -		ERR("regerror returned a length of 0");
> -		return;
> -	}
> -
> -	buffer =3D zmalloc(length);
> -	if (!buffer) {
> -		ERR("regex_print_error: zmalloc failed");
> -		return;
> -	}
> -
> -	/* Get and print error message */
> -	regerror(errcode, regex, buffer, length);
> -	ERR("regex error: %s\n", buffer);
> -	free(buffer);
> -
> -}
> =20
>  /**
>   * Parse a string that represents a size in human readable format. It
> - * supports decimal integers suffixed by 'k', 'M' or 'G'.
> + * supports decimal integers suffixed by 'k', 'K', 'M' or 'G'.
>   *
>   * The suffix multiply the integer by:
>   * 'k': 1024
> @@ -693,83 +660,94 @@ static void regex_print_error(int errcode, regex_t =
*regex)
>   * 'G': 1024^3
>   *
>   * @param str	The string to parse.
> - * @param size	Pointer to a size_t that will be filled with the
> + * @param size	Pointer to a uint64_t that will be filled with the
>   *		resulting size.
>   *
>   * @return 0 on success, -1 on failure.
>   */
>  LTTNG_HIDDEN
> -int utils_parse_size_suffix(char *str, uint64_t *size)
> +int utils_parse_size_suffix(const char * const str, uint64_t * const siz=
e)
>  {
> -	regex_t regex;
>  	int ret;
> -	const int nmatch =3D 3;
> -	regmatch_t suffix_match, matches[nmatch];
> -	unsigned long long base_size;
> +	uint64_t base_size;
>  	long shift =3D 0;
> +	const char *str_end;
> +	char *num_end;
> =20
>  	if (!str) {
> -		return 0;
> -	}
> -
> -	/* Compile regex */
> -	ret =3D regcomp(&regex, "^\\(0x\\)\\{0,1\\}[0-9][0-9]*\\([kKMG]\\{0,1\\=
}\\)$", 0);
> -	if (ret !=3D 0) {
> -		regex_print_error(ret, &regex);
> +		DBG("utils_parse_size_suffix: received a NULL string.");
>  		ret =3D -1;
>  		goto end;
>  	}
> =20
> -	/* Match regex */
> -	ret =3D regexec(&regex, str, nmatch, matches, 0);
> -	if (ret !=3D 0) {
> +	/* strtoull will accept a negative number, but we don't want to. */
> +	if (strchr(str, '-') !=3D NULL) {
> +		DBG("utils_parse_size_suffix: invalid size string, should not contain =
'-'.");
>  		ret =3D -1;
> -		goto free;
> +		goto end;
>  	}
> =20
> -	/* There is a match ! */
> +	/* str_end will point to the \0 */
> +	str_end =3D str + strlen(str);
>  	errno =3D 0;
> -	base_size =3D strtoull(str, NULL, 0);
> +	base_size =3D strtoull(str, &num_end, 0);
>  	if (errno !=3D 0) {
> -		PERROR("strtoull");
> +		PERROR("utils_parse_size_suffix strtoull");
>  		ret =3D -1;
> -		goto free;
> +		goto end;
>  	}
> =20
> -	/* Check if there is a suffix */
> -	suffix_match =3D matches[2];
> -	if (suffix_match.rm_eo - suffix_match.rm_so =3D=3D 1) {
> -		switch (*(str + suffix_match.rm_so)) {
> -		case 'K':
> -		case 'k':
> -			shift =3D KIBI_LOG2;
> -			break;
> -		case 'M':
> -			shift =3D MEBI_LOG2;
> -			break;
> -		case 'G':
> -			shift =3D GIBI_LOG2;
> -			break;
> -		default:
> -			ERR("parse_human_size: invalid suffix");
> -			ret =3D -1;
> -			goto free;
> -		}
> +	if (num_end =3D=3D str) {
> +		/* strtoull parsed nothing, not good. */
> +		DBG("utils_parse_size_suffix: strtoull had nothing good to parse.\n");
> +		ret =3D -1;
> +		goto end;
> +	}
> +
> +	/* Check if a prefix is present. */
> +	switch (*num_end) {
> +	case 'G':
> +		shift =3D GIBI_LOG2;
> +		num_end++;
> +		break;
> +
> +	case 'M': /*  */
> +		shift =3D MEBI_LOG2;
> +		num_end++;
> +		break;
> +
> +	case 'K':
> +	case 'k':
> +		shift =3D KIBI_LOG2;
> +		num_end++;
> +		break;
> +
> +	case '\0':
> +		break;
> +
> +	default:
> +		DBG("utils_parse_size_suffix: invalid suffix.\n");
> +		ret =3D -1;
> +		goto end;
> +	}
> +
> +	/* Check for garbage after the valid input. */
> +	if (num_end !=3D str_end) {
> +		DBG("utils_parse_size_suffix: Garbage after size string.");
> +		ret =3D -1;
> +		goto end;
>  	}
> =20
>  	*size =3D base_size << shift;
> =20
>  	/* Check for overflow */
>  	if ((*size >> shift) !=3D base_size) {
> -		ERR("parse_size_suffix: oops, overflow detected.");
> +		DBG("utils_parse_size_suffix: oops, overflow detected.");
>  		ret =3D -1;
> -		goto free;
> +		goto end;
>  	}
> =20
>  	ret =3D 0;
> -
> -free:
> -	regfree(&regex);
>  end:
>  	return ret;
>  }
> diff --git a/src/common/utils.h b/src/common/utils.h
> index 63290a7..b872b53 100644
> --- a/src/common/utils.h
> +++ b/src/common/utils.h
> @@ -43,7 +43,7 @@ int utils_create_stream_file(const char *path_name, cha=
r *file_name, uint64_t si
>  int utils_rotate_stream_file(char *path_name, char *file_name, uint64_t =
size,
>  		uint64_t count, int uid, int gid, int out_fd, uint64_t *new_count,
>  		int *stream_fd);
> -int utils_parse_size_suffix(char *str, uint64_t *size);
> +int utils_parse_size_suffix(char const * const str, uint64_t * const siz=
e);
>  int utils_get_count_order_u32(uint32_t x);
>  char *utils_get_home_dir(void);
>  char *utils_get_user_home_dir(uid_t uid);
> diff --git a/tests/unit/test_utils_parse_size_suffix.c b/tests/unit/test_=
utils_parse_size_suffix.c
> index 990aa1b..45a87b0 100644
> --- a/tests/unit/test_utils_parse_size_suffix.c
> +++ b/tests/unit/test_utils_parse_size_suffix.c
> @@ -43,11 +43,63 @@ static struct valid_test_input valid_tests_inputs[] =
=3D {
>  		{ "0x1234k", 4771840 },
>  		{ "32M", 33554432 },
>  		{ "1024G", 1099511627776 },
> +		{ "0X400", 1024 },
> +		{ "0x40a", 1034 },
> +		{ "0X40b", 1035 },
> +		{ "0x40C", 1036 },
> +		{ "0X40D", 1037 },
> +		{ "0x40e", 1038 },
> +		{ "0X40f", 1039 },
> +		{ "00", 0 },
> +		{ "0k", 0 },
> +		{ "0K", 0 },
> +		{ "0M", 0 },
> +		{ "0G", 0 },
> +		{ "00k", 0 },
> +		{ "00K", 0 },
> +		{ "00M", 0 },
> +		{ "00G", 0 },
> +		{ "0x0", 0 },
> +		{ "0X0", 0 },
> +		{ "0x0k", 0 },
> +		{ "0X0K", 0 },
> +		{ "0x0M", 0 },
> +		{ "0X0G", 0 },
> +		{ "0X40G", 68719476736 },
> +		{ "0300k", 196608 },
> +		{ "0300K", 196608 },
> +		{ "030M", 25165824 },
> +		{ "020G", 17179869184 },
> +		{ "0xa0k", 163840 },
> +		{ "0xa0K", 163840 },
> +		{ "0XA0M", 167772160 },
> +		{ "0xA0G", 171798691840 },
>  };
>  static const int num_valid_tests =3D sizeof(valid_tests_inputs) / sizeof=
(valid_tests_inputs[0]);
> =20
>  /* Invalid test cases */
> -static char *invalid_tests_inputs[] =3D { "", "-1", "k", "46116860184273=
87904G" };
> +static char *invalid_tests_inputs[] =3D {
> +		"",
> +		" ",
> +		"-1",
> +		"k",
> +		"4611686018427387904G",
> +		"0x40g",
> +		"08",
> +		"09",
> +		"0x",
> +		"x0",
> +		"0xx0",
> +		"07kK",
> +		"0xk",
> +		"0XM",
> +		"0xG",
> +		"0x0MM",
> +		"0X0GG",
> +		"0a",
> +		"0B",
> +};
> +
>  static const int num_invalid_tests =3D sizeof(invalid_tests_inputs) / si=
zeof(invalid_tests_inputs[0]);
> =20
>  static void test_utils_parse_size_suffix(void)
> --=20
> 1.9.1
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTS/RAXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02LkAH/j50au1vktmYR+PCwWbA9bXR
CYU0Jc1WEjTehXSE4flTyx+6lThaLPrFtDyJvide2GZHdJPboJ3Iv7bp5BILIfqo
cGXTu6SkGd3RjPggRLFtocLheXxltHPEI3Y4p5B0VfMAiArkJsjQSzx5pLkFdJbL
zpr4maINN0qk17pe958L5GeIPQb/0pPPuud5vLjH+OxxVTkb+iMvhTwYRpCTPkAR
gu5jumwf74j6QV6EAPoPTVlkXKMr2aujdIJRD83l3exfWZT+cyNcPdQmhwHd9DDF
OAmpHoLMcDYDc8pFxh4M25WXxqcaSuVxz3o1WACxwG8hKZyLdVaSFrdG2MotT1w=
=YPnK
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--


--===============1562804341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1562804341==--
