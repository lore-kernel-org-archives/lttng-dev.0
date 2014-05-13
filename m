From: David Goulet <dgoulet@efficios.com>
Subject: Re: Patch mi lttng
Date: Tue, 13 May 2014 13:32:57 -0400
Message-ID: <20140513173257.GG7414__14559.966143179$1400002493$gmane$org@thessa>
References: <CAF4oYfFF-vCcmwNqg7du1kL02QetER-oaOhmAMr8PcxkTWMgYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1831437338=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ns236805.ip-192-99-35.net ([192.99.35.19]
 helo=smtp.ini-tech.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WkGZj-0005bJ-52
 for lttng-dev@lists.lttng.org; Tue, 13 May 2014 13:33:21 -0400
In-Reply-To: <CAF4oYfFF-vCcmwNqg7du1kL02QetER-oaOhmAMr8PcxkTWMgYg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1831437338==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eVzOFob/8UvintSX"
Content-Disposition: inline


--eVzOFob/8UvintSX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As discussed on #lttng, this looks good to me.

Since you might continue working on this to support all command, I would
be more keen to merge that in 2.6 with every command working instead of
half of it.

It's important to consider the fact that once merged and released this
becomes a public ABI thus we'll be committed to it. I'll be way more
comfortable with all the commands implemented so we can expose at once
the full ABI and maybe fix issues on the way without having the burden
of backward compatibility.

Please raise your hand if you are not happy nor ok with this or have a
better idea :).

Cheers!
David

On 21 Apr (17:05:24), Jonathan Rajotte wrote:
> Salut,
>=20
> Donc voici les patchs r=E9alis=E9s dans le cadre du projet.(sans compter =
la
> premiere qui est sur la branche =E0 David d=E9ja [1]). Elles sont bas=E9e=
s sur
> cet branche [1].
>=20
> J'=E9tais en train de mettre en place des tests mais le temps me manque et
> je ne suis pas un expert bash, ce qui ralentit un peu les choses car
> manipuler du xml en bash c'est pas facile (en tout cas pas pour moi).
>=20
> J'ai une patch de bash completion. Cependant elle force une d=E9pendance =
vers
> xmllint... et bon j'ai pas trouv=E9 de commande bash afin de v=E9rifier la
> pr=E9sence de xmllint qui soit fiable =E0 tout coup.
>=20
> Je suis en fin de session pour l'instant donc je ne pourrais pas assurer =
un
> suivi efficace de tout cela. Mais je veux vraiment que cette feature soit
> accept=E9 au final.
>=20
> Bref voil=E0 !
>=20
> Merci encore pour l'exp=E9rience. Si ce n'=E9tait pas de vous mon projet 4
> aurait =E9t=E9 p=E9nible.
>=20
> https://github.com/dgoulet/lttng-tools-dev/tree/mi
>=20
> --=20
> Jonathan Rajotte Julien
> Charg=E9 de laboratoire, INF1995
> Polytechnique Montr=E9al

> From 1652234b660950b84b4eb7bdc924092761c4cdb8 Mon Sep 17 00:00:00 2001
> From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
> Date: Wed, 16 Apr 2014 16:08:38 -0400
> Subject: [PATCH 1/5] Mi: add mi support for lttng struct
>=20
> Add mi-lttng support to the following struct:
>     lttng_domain
>     lttng_channel
>     lttng_channel_attr
>     lttng_event
>         +multiple mi utility format:
>             common attribute
>             tracepoint_loglevel
>             tracepoint_no_loglevel
>             function probe
>             function entry
>     lttng_event_field
>=20
> mi-lttng other element
>     pid element
>=20
> Signed-off-by: Jonathan Rajotte <jonathan.r.julien@gmail.com>
> ---
>  src/common/mi-lttng.c | 668 ++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  src/common/mi-lttng.h | 296 +++++++++++++++++++++-
>  2 files changed, 949 insertions(+), 15 deletions(-)
>=20
> diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c
> index 052b542..2e4c366 100644
> --- a/src/common/mi-lttng.c
> +++ b/src/common/mi-lttng.c
> @@ -16,11 +16,13 @@
>   * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>   */
> =20
> +
>  #include <include/config.h>
>  #include <common/config/config.h>
> -
>  #include "mi-lttng.h"
> =20
> +#include <assert.h>
> +
>  /* Strings related to command */
>  const char * const mi_lttng_element_command =3D "command";
>  const char * const mi_lttng_element_command_version =3D "version";
> @@ -38,6 +40,133 @@ const char * const mi_lttng_element_version_license =
=3D "license";
>  const char * const mi_lttng_element_version_patch_level =3D "patchLevel";
>  const char * const mi_lttng_element_version_description =3D "description=
";
> =20
> +/* Strings related to pid */
> +const char * const mi_lttng_element_pids =3D "pids";
> +const char * const mi_lttng_element_pid =3D "pid";
> +const char * const mi_lttng_element_pid_id =3D "id";
> +
> +/* String related to a lttng_event_field */
> +const char * const mi_lttng_element_event_field =3D "event_field";
> +const char * const mi_lttng_element_event_fields =3D "event_fields";
> +
> +/* General elements of mi_lttng */
> +const char * const mi_lttng_element_type_other =3D "OTHER";
> +const char * const mi_lttng_element_type_integer =3D "INTEGER";
> +const char * const mi_lttng_element_type_enum =3D "ENUM";
> +const char * const mi_lttng_element_type_float =3D "FLOAT";
> +const char * const mi_lttng_element_type_string =3D "STRING";
> +const char * const mi_lttng_element_nowrite =3D "nowrite";
> +
> +const char * const mi_lttng_element_empty =3D "";
> +
> +const char *mi_lttng_loglevel_string(int value)
> +{
> +	switch (value) {
> +	case -1:
> +		return "";
> +	case LTTNG_LOGLEVEL_EMERG:
> +		return "TRACE_EMERG";
> +	case LTTNG_LOGLEVEL_ALERT:
> +		return "TRACE_ALERT";
> +	case LTTNG_LOGLEVEL_CRIT:
> +		return "TRACE_CRIT";
> +	case LTTNG_LOGLEVEL_ERR:
> +		return "TRACE_ERR";
> +	case LTTNG_LOGLEVEL_WARNING:
> +		return "TRACE_WARNING";
> +	case LTTNG_LOGLEVEL_NOTICE:
> +		return "TRACE_NOTICE";
> +	case LTTNG_LOGLEVEL_INFO:
> +		return "TRACE_INFO";
> +	case LTTNG_LOGLEVEL_DEBUG_SYSTEM:
> +		return "TRACE_DEBUG_SYSTEM";
> +	case LTTNG_LOGLEVEL_DEBUG_PROGRAM:
> +		return "TRACE_DEBUG_PROGRAM";
> +	case LTTNG_LOGLEVEL_DEBUG_PROCESS:
> +		return "TRACE_DEBUG_PROCESS";
> +	case LTTNG_LOGLEVEL_DEBUG_MODULE:
> +		return "TRACE_DEBUG_MODULE";
> +	case LTTNG_LOGLEVEL_DEBUG_UNIT:
> +		return "TRACE_DEBUG_UNIT";
> +	case LTTNG_LOGLEVEL_DEBUG_FUNCTION:
> +		return "TRACE_DEBUG_FUNCTION";
> +	case LTTNG_LOGLEVEL_DEBUG_LINE:
> +		return "TRACE_DEBUG_LINE";
> +	case LTTNG_LOGLEVEL_DEBUG:
> +		return "TRACE_DEBUG";
> +	default:
> +		return "UNKNOWN";
> +	}
> +}
> +
> +const char *mi_lttng_logleveltype_string(enum lttng_loglevel_type value)
> +{
> +	switch (value) {
> +	case LTTNG_EVENT_LOGLEVEL_ALL:
> +		return "ALL";
> +	case LTTNG_EVENT_LOGLEVEL_RANGE:
> +		return "RANGE";
> +	case LTTNG_EVENT_LOGLEVEL_SINGLE:
> +		return "SINGLE";
> +	default:
> +		return "UNKNOWN";
> +	}
> +}
> +
> +const char *mi_lttng_eventtype_string(enum lttng_event_type value)
> +{
> +	switch (value) {
> +	case LTTNG_EVENT_ALL:
> +		return config_event_type_all;
> +		break;
> +	case LTTNG_EVENT_TRACEPOINT:
> +		return config_event_type_tracepoint;
> +		break;
> +	case LTTNG_EVENT_PROBE:
> +		return config_event_type_probe;
> +		break;
> +	case LTTNG_EVENT_FUNCTION:
> +		return config_event_type_function;
> +		break;
> +	case LTTNG_EVENT_FUNCTION_ENTRY:
> +		return config_event_type_function_entry;
> +		break;
> +	case LTTNG_EVENT_SYSCALL:
> +		return config_event_type_syscall;
> +		break;
> +	case LTTNG_EVENT_NOOP:
> +		return config_event_type_noop;
> +		break;
> +	default:
> +		return mi_lttng_element_empty;
> +		break;
> +	}
> +}
> +
> +const char *eventfieldtype_string(enum lttng_event_field_type val)
> +{
> +	const char *ret;
> +
> +	switch (val) {
> +	case(LTTNG_EVENT_FIELD_INTEGER):
> +		ret =3D mi_lttng_element_type_integer;
> +		break;
> +	case(LTTNG_EVENT_FIELD_ENUM):
> +		ret =3D mi_lttng_element_type_enum;
> +		break;
> +	case(LTTNG_EVENT_FIELD_FLOAT):
> +		ret =3D mi_lttng_element_type_float;
> +		break;
> +	case(LTTNG_EVENT_FIELD_STRING):
> +		ret =3D mi_lttng_element_type_string;
> +		break;
> +	default:
> +		ret =3D mi_lttng_element_type_other;
> +		break;
> +	}
> +	return ret;
> +}
> +
>  LTTNG_HIDDEN
>  struct mi_writer *mi_lttng_writer_create(int fd_output, int mi_output_ty=
pe)
>  {
> @@ -90,7 +219,6 @@ LTTNG_HIDDEN
>  int mi_lttng_writer_command_open(struct mi_writer *writer, const char *c=
ommand)
>  {
>  	int ret;
> -
>  	ret =3D mi_lttng_writer_open_element(writer, mi_lttng_element_command);
>  	if (ret) {
>  		goto end;
> @@ -121,6 +249,25 @@ int mi_lttng_writer_close_element(struct mi_writer *=
writer)
>  }
> =20
>  LTTNG_HIDDEN
> +int mi_lttng_close_multi_element(struct mi_writer *writer,
> +		unsigned int nb_element)
> +{
> +	int ret, i;
> +	if (nb_element < 1) {
> +		ret =3D 0;
> +		goto end;
> +	}
> +	for (i =3D 0; i < nb_element; i++) {
> +		ret =3D mi_lttng_writer_close_element(writer);
> +		if (ret) {
> +			goto end;
> +		}
> +	}
> +end:
> +	return ret;
> +}
> +
> +LTTNG_HIDDEN
>  int mi_lttng_writer_write_element_unsigned_int(struct mi_writer *writer,
>  		const char *element_name, uint64_t value)
>  {
> @@ -228,12 +375,20 @@ end:
>  }
> =20
>  LTTNG_HIDDEN
> +int mi_lttng_sessions_open(struct mi_writer *writer)
> +{
> +	return mi_lttng_writer_open_element(writer, config_element_sessions);
> +}
> +
> +LTTNG_HIDDEN
>  int mi_lttng_session(struct mi_writer *writer,
>  		struct lttng_session *session, int is_open)
>  {
>  	int ret;
> =20
> -	/* open sessions element */
> +	assert(session);
> +
> +	/* Open sessions element */
>  	ret =3D mi_lttng_writer_open_element(writer,
>  			config_element_session);
>  	if (ret) {
> @@ -247,28 +402,28 @@ int mi_lttng_session(struct mi_writer *writer,
>  		goto end;
>  	}
> =20
> -	/* path */
> +	/* Path */
>  	ret =3D mi_lttng_writer_write_element_string(writer,
>  			config_element_path, session->path);
>  	if (ret) {
>  		goto end;
>  	}
> =20
> -	/* enabled ? */
> -	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +	/* Enabled ? */
> +	ret =3D mi_lttng_writer_write_element_bool(writer,
>  			config_element_enabled, session->enabled);
>  	if (ret) {
>  		goto end;
>  	}
> =20
> -	/* snapshot mode */
> +	/* Snapshot mode */
>  	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
>  			config_element_snapshot_mode, session->snapshot_mode);
>  	if (ret) {
>  		goto end;
>  	}
> =20
> -	/* live timer interval in usec */
> +	/* Live timer interval in usec */
>  	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
>  			config_element_live_timer_interval,
>  			session->live_timer_interval);
> @@ -284,3 +439,500 @@ end:
>  	return ret;
> =20
>  }
> +
> +LTTNG_HIDDEN
> +int mi_lttng_domains_open(struct mi_writer *writer)
> +{
> +	return mi_lttng_writer_open_element(writer, config_element_domains);
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_domain(struct mi_writer *writer,
> +		struct lttng_domain *domain, int is_open)
> +{
> +	int ret =3D 0;
> +	const char *str_domain;
> +	const char *str_buffer;
> +
> +	assert(domain);
> +
> +	/* Open domain element */
> +	ret =3D mi_lttng_writer_open_element(writer, config_element_domain);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Type
> +	 * Note: This is a *duplicate* of get_domain_str from bin/lttng/utils.c
> +	 */
> +	switch (domain->type) {
> +	case LTTNG_DOMAIN_KERNEL:
> +		str_domain =3D config_domain_type_kernel;
> +		break;
> +	case LTTNG_DOMAIN_UST:
> +		str_domain =3D config_domain_type_ust;
> +		break;
> +	case LTTNG_DOMAIN_JUL:
> +		str_domain =3D config_domain_type_jul;
> +		break;
> +	default:
> +		/* Should not have an unknown domain */
> +		assert(0);
> +	}
> +
> +	ret =3D mi_lttng_writer_write_element_string(writer, config_element_typ=
e,
> +			str_domain);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Buffer Type */
> +	switch (domain->buf_type) {
> +	case LTTNG_BUFFER_PER_PID:
> +		str_buffer =3D config_buffer_type_per_pid;
> +		break;
> +	case LTTNG_BUFFER_PER_UID:
> +		str_buffer =3D config_buffer_type_per_uid;
> +		break;
> +	case LTTNG_BUFFER_GLOBAL:
> +		str_buffer =3D config_buffer_type_global;
> +		break;
> +	default:
> +		/* Shoul not have an unknow buffer type */
> +		assert(0);
> +	}
> +
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +			config_element_buffer_type, str_buffer);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* TODO: attr... not sure how to use the union.... */
> +
> +	if (!is_open) {
> +		/* Closing domain element */
> +		ret =3D mi_lttng_writer_close_element(writer);
> +	}
> +
> +end:
> +	return ret;
> +
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_channels_open(struct mi_writer *writer)
> +{
> +	return mi_lttng_writer_open_element(writer, config_element_channels);
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_channel(struct mi_writer *writer,
> +		struct lttng_channel *channel, int is_open)
> +{
> +	int ret =3D 0;
> +
> +	assert(channel);
> +
> +	/* Opening channel element */
> +	ret =3D mi_lttng_writer_open_element(writer, config_element_channel);
> +	if (ret) {
> +		goto end;
> +	}
> +	/* Name */
> +	ret =3D mi_lttng_writer_write_element_string(writer, config_element_nam=
e,
> +			channel->name);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Enabled ? */
> +	ret =3D mi_lttng_writer_write_element_bool(writer,
> +			config_element_enabled, channel->enabled);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Attribute */
> +	ret =3D mi_lttng_channel_attr(writer, &channel->attr);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	if (!is_open) {
> +		/* Closing channel element */
> +		ret =3D mi_lttng_writer_close_element(writer);
> +		if (ret) {
> +			goto end;
> +		}
> +	}
> +end:
> +	return ret;
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_channel_attr(struct mi_writer *writer,
> +		struct lttng_channel_attr *attr)
> +{
> +	int ret =3D 0;
> +
> +	assert(attr);
> +
> +	/* Opening Attributes */
> +	ret =3D mi_lttng_writer_open_element(writer, config_element_attributes);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Overwrite */
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +		config_element_overwrite_mode,
> +		attr->overwrite ? config_overwrite_mode_overwrite :
> +			config_overwrite_mode_discard);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Sub buffer size in byte */
> +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +		config_element_subbuf_size, attr->subbuf_size);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Number of sub buffer (power of two) */
> +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +		config_element_num_subbuf,
> +		attr->num_subbuf);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Switch timer interval in usec */
> +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +		config_element_switch_timer_interval,
> +		attr->switch_timer_interval);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Read timer interval in usec */
> +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +		config_element_read_timer_interval,
> +		attr->read_timer_interval);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Event output */
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +		config_element_output_type,
> +		attr->output =3D=3D LTTNG_EVENT_SPLICE ?
> +		config_output_type_splice : config_output_type_mmap);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Tracefile size in bytes */
> +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +		config_element_tracefile_size, attr->tracefile_size);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Count of tracefiles */
> +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +		config_element_tracefile_count,
> +		attr->tracefile_count);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Live timer interval in usec*/
> +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +		config_element_live_timer_interval,
> +		attr->live_timer_interval);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Closing attributes */
> +	ret =3D mi_lttng_writer_close_element(writer);
> +	if (ret) {
> +		goto end;
> +	}
> +end:
> +	return ret;
> +
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_event_common_attributes(struct mi_writer *writer,
> +		struct lttng_event *event)
> +{
> +	int ret;
> +
> +	/* Open event element */
> +	ret =3D mi_lttng_writer_open_element(writer, config_element_event);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* event name */
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +			config_element_name, event->name);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* event type */
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +			config_element_type, mi_lttng_eventtype_string(event->type));
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* is event enabled */
> +	ret =3D mi_lttng_writer_write_element_bool(writer,
> +			config_element_enabled, event->enabled);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* event filter enabled? */
> +	ret =3D mi_lttng_writer_write_element_bool(writer,
> +			config_element_filter, event->filter);
> +
> +end:
> +	return ret;
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_event_tracepoint_loglevel(struct mi_writer *writer,
> +		struct lttng_event *event)
> +{
> +	int ret;
> +
> +	/* event loglevel */
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +			config_element_loglevel, mi_lttng_loglevel_string(event->loglevel));
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +			config_element_loglevel_type,
> +			mi_lttng_logleveltype_string(event->loglevel_type));
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* event exclusion filter */
> +	ret =3D mi_lttng_writer_write_element_bool(writer,
> +			config_element_exclusion, event->exclusion);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +end:
> +	return ret;
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_event_tracepoint_no_loglevel(struct mi_writer *writer,
> +		struct lttng_event *event)
> +{
> +	/* event exclusion filter */
> +	return mi_lttng_writer_write_element_bool(writer,
> +			config_element_exclusion, event->exclusion);
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_event_function_probe(struct mi_writer *writer,
> +		struct lttng_event *event)
> +{
> +	int ret;
> +
> +	if (event->attr.probe.addr !=3D 0) {
> +		/* event probe address */
> +		ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +				config_element_address, event->attr.probe.addr);
> +		if (ret) {
> +			goto end;
> +		}
> +	} else {
> +		/* event probe offset */
> +		ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +				config_element_offset, event->attr.probe.offset);
> +		if (ret) {
> +			goto end;
> +		}
> +
> +		/* event probe symbol_name */
> +		ret =3D mi_lttng_writer_write_element_string(writer,
> +				config_element_symbol_name, event->attr.probe.symbol_name);
> +		if (ret) {
> +			goto end;
> +		}
> +	}
> +end:
> +	return ret;
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_event_function_entry(struct mi_writer *writer,
> +		struct lttng_event *event)
> +{
> +	/* event probe symbol_name */
> +	return mi_lttng_writer_write_element_string(writer,
> +			config_element_symbol_name, event->attr.ftrace.symbol_name);
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_events_open(struct mi_writer *writer)
> +{
> +	return mi_lttng_writer_open_element(writer, config_element_events);
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_event(struct mi_writer *writer,
> +		struct lttng_event *event, int is_open)
> +{
> +	int ret;
> +
> +	ret =3D mi_lttng_event_common_attributes(writer, event);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	switch (event->type) {
> +	case LTTNG_EVENT_ALL:
> +		/* We should never have "all" events in list. */
> +		assert(0);
> +		break;
> +	case LTTNG_EVENT_TRACEPOINT:
> +	{
> +		if (event->loglevel !=3D -1) {
> +			ret =3D mi_lttng_event_tracepoint_loglevel(writer, event);
> +		} else {
> +			ret =3D mi_lttng_event_tracepoint_no_loglevel(writer, event);
> +		}
> +		break;
> +	}
> +	case LTTNG_EVENT_PROBE:
> +		ret =3D mi_lttng_event_function_probe(writer, event);
> +		break;
> +	case LTTNG_EVENT_FUNCTION_ENTRY:
> +		ret =3D mi_lttng_event_function_entry(writer, event);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (!is_open) {
> +		ret =3D mi_lttng_writer_close_element(writer);
> +	}
> +
> +end:
> +	return ret;
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_pids_open(struct mi_writer *writer)
> +{
> +	return mi_lttng_writer_open_element(writer, mi_lttng_element_pids);
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_pid(struct mi_writer *writer, pid_t pid , const char *cmdli=
ne,
> +		int is_open)
> +{
> +	int ret;
> +
> +	/* Open element pid */
> +	ret =3D mi_lttng_writer_open_element(writer, mi_lttng_element_pid);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Writing pid number */
> +	ret =3D mi_lttng_writer_write_element_signed_int(writer,
> +			mi_lttng_element_pid_id, (int)pid);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Writing name of the process */
> +	ret =3D mi_lttng_writer_write_element_string(writer, config_element_nam=
e,
> +			cmdline);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	if (!is_open) {
> +		/* Closing Pid */
> +		ret =3D mi_lttng_writer_close_element(writer);
> +	}
> +
> +end:
> +	return ret;
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_event_fields_open(struct mi_writer *writer)
> +{
> +	return mi_lttng_writer_open_element(writer, mi_lttng_element_event_fiel=
ds);
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_event_field(struct mi_writer *writer,
> +		struct lttng_event_field *field)
> +{
> +	int ret;
> +
> +	if (!field->field_name[0]) {
> +		/* To Review: not sure if legal david ?
> +		 * how should this be handle ?
> +		 */
> +		ret =3D 0;
> +		goto end;
> +	}
> +
> +	/* Open field */
> +	ret =3D mi_lttng_writer_open_element(writer, mi_lttng_element_event_fie=
ld);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	if (!field->field_name[0]) {
> +		goto close;
> +	}
> +
> +	/* Name */
> +	ret =3D mi_lttng_writer_write_element_string(writer, config_element_nam=
e,
> +			field->field_name);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Type */
> +	ret =3D mi_lttng_writer_write_element_string(writer, config_element_typ=
e,
> +			eventfieldtype_string(field->type));
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* nowrite  */
> +	ret =3D mi_lttng_writer_write_element_signed_int(writer,
> +			mi_lttng_element_nowrite, field->nowrite);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +close:
> +	/* Close field element */
> +	ret =3D mi_lttng_writer_close_element(writer);
> +
> +end:
> +	return ret;
> +}
> diff --git a/src/common/mi-lttng.h b/src/common/mi-lttng.h
> index bdc4a05..2dca80c 100644
> --- a/src/common/mi-lttng.h
> +++ b/src/common/mi-lttng.h
> @@ -61,6 +61,28 @@ const char * const mi_lttng_element_version_license;
>  const char * const mi_lttng_element_version_patch_level;
>  const char * const mi_lttng_element_version_description;
> =20
> +/* String related to a lttng_event_field */
> +const char * const mi_lttng_element_event_field;
> +const char * const mi_lttng_element_event_fields;
> +
> +/* Strings related to pid */
> +const char * const mi_lttng_element_pids;
> +const char * const mi_lttng_element_pid;
> +const char * const mi_lttng_element_pid_id;
> +
> +/* General element of mi_lttng */
> +const char * const mi_lttng_element_type_other;
> +const char * const mi_lttng_element_type_integer;
> +const char * const mi_lttng_element_type_enum;
> +const char * const mi_lttng_element_type_float;
> +const char * const mi_lttng_element_type_string;
> +const char * const mi_lttng_element_nowrite;
> +
> +/* Utility string function  */
> +const char *mi_lttng_loglevel_string(int value);
> +const char *mi_lttng_logleveltype_string(enum lttng_loglevel_type value);
> +const char *mi_lttng_eventfieldtype_string(enum lttng_event_field_type v=
alue);
> +
>  /*
>   * Create an instance of a machine interface writer.
>   *
> @@ -128,6 +150,19 @@ int mi_lttng_writer_open_element(struct mi_writer *w=
riter,
>  int mi_lttng_writer_close_element(struct mi_writer *writer);
> =20
>  /*
> + * Close multiple element.
> + *
> + * writer An instance of a machine interface writer.
> + *
> + * nb_element
> + *
> + * Returns zero if the XML document could be closed cleanly.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_close_multi_element(struct mi_writer *writer,
> +		unsigned int nb_element);
> +
> +/*
>   * Write an element of type unsigned int.
>   *
>   * writer An instance of a machine interface writer.
> @@ -205,24 +240,271 @@ int mi_lttng_version(struct mi_writer *writer, str=
uct mi_lttng_version *version,
>  		const char *lttng_description, const char *lttng_license);
> =20
>  /*
> + * Machine interface: open a sessions element.
> + *
> + * writer An instance of a machine interface writer
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_sessions_open(struct mi_writer *writer);
> +
> +/*
>   * Machine interface of struct session.
>   *
>   * writer An instance of a machine interface writer
>   *
>   * session An instance of a session
>   *
> - * isOpen Define if we close the session element
> - *        This should be use carefully and the client
> - *        need to close the session element.
> - *        Use case: nested addition information on a session
> + * is_open Define if we close the session element
> + *         This should be used carefully and the client
> + *         need to close the session element.
> + *         Use case: nested addtionnal information on a session
>   *                  ex: domain,channel event.
> - *        0-> False
> - *        1-> True
> + *         0-> False
> + *         1-> True
>   *
>   * Returns zero if the element's value could be written.
>   * Negative values indicate an error.
>   */
>  int mi_lttng_session(struct mi_writer *writer,
> -		struct lttng_session *session, int isOpen);
> +		struct lttng_session *session, int is_open);
> +
> +/*
> + * Machine interface: open a domains element.
> + *
> + * writer An instance of a machine interface writer
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_domains_open(struct mi_writer *writer);
> +
> +/*
> + * Machine interface of struct domain.
> + *
> + * writer An instance of a machine interface writer
> + *
> + * domain An instance of a domain
> + *
> + * is_open Define if we close the domain element
> + *         This should be used carefully and the client
> + *         need to close the domain element.
> + *         Use case: nested addition information on a domain
> + *                  ex: channel event.
> + *         0-> False
> + *         1-> True
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_domain(struct mi_writer *writer,
> +		struct lttng_domain *domain, int is_open);
> +
> +/*
> + * Machine interface: open a channels element.
> + *
> + * writer An instance of a machine interface writer
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_channels_open(struct mi_writer *writer);
> +
> +/*
> + * Machine interface of struct channel.
> + *
> + * writer An instance of a machine interface writer
> + *
> + * channel An instance of a channel
> + *
> + * is_open Define if we close the channel element
> + *         This should be used carefully and the client
> + *         need to close the channel element.
> + *         Use case: nested addition information on a domain
> + *                  ex: channel event.
> + *         0-> False
> + *         1-> True
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_channel(struct mi_writer *writer,
> +		struct lttng_channel *channel, int is_open);
> +
> +/*
> + * Machine interface of struct channel_attr.
> + *
> + * writer An instance of a machine interface writer
> + *
> + * attr An instance of a channel_attr struct
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_channel_attr(struct mi_writer *writer,
> +		struct lttng_channel_attr *attr);
> +
> +/*
> +* Machine interface for event common attribute.
> +*
> +* writer An instance of a mi writer.
> +*
> +* event single trace event.
> +*
> +* The common attribute are:
> +* - mi event element
> +* - event name
> +* - event type
> +* - enabled tag
> +* - event filter
> +*
> +* Returns zero if the element's value could be written.
> +* Negative values indicate an error.
> +*/
> +int mi_lttng_event_common_attributes(struct mi_writer *writer,
> +		struct lttng_event *event);
> +
> +/*
> + * Machine interface for kernel tracepoint event with a loglevel.
> + *
> + * writer An instance of a mi writer.
> + *
> + * event single trace event.
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_event_tracepoint_loglevel(struct mi_writer *writer,
> +		struct lttng_event *event);
> +
> +/*
> + * Machine interface for kernel tracepoint event with no loglevel.
> + *
> + * writer An instance of a mi writer.
> + *
> + * event single trace event.
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_event_tracepoint_no_loglevel(struct mi_writer *writer,
> +		struct lttng_event *event);
> +
> +/*
> + * Machine interface for kernel function and probe event.
> + *
> + * writer An instance of a mi writer.
> + *
> + * event single trace event.
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_event_function_probe(struct mi_writer *writer,
> +		struct lttng_event *event);
> +
> +/*
> + * Machine interface for kernel function entry event.
> + *
> + * writer An instance of a mi writer.
> + *
> + * event single trace event.
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_event_function_entry(struct mi_writer *writer,
> +		struct lttng_event *event);
> +
> +/*
> + * Machine interface: open an events element.
> + *
> + * writer An instance of a machine interface writer
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_events_open(struct mi_writer *writer);
> +
> +/*
> + * Machine interface for printing an event.
> + * The trace event type currently supported are:
> + *  TRACEPOINT,
> + *  PROBE,
> + *  FUNCTION,
> + *  FUNCTION_ENTRY,
> + *  SYSCALL
> + *
> + * writer An instance of a mi writer.
> + *
> + * event single trace event.
> + *
> + * is_open Define if we close the event element
> + *         This should be used carefully and the client
> + *         need to close the event element.
> + *         Use case: nested additional information
> + *         0-> False
> + *         1-> True
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_event(struct mi_writer *writer, struct lttng_event *event,
> +		int is_open);
> +
> +/*
> + * Machine interface for struct lttng_event_field .
> + *
> + * writer An instance of a mi writer.
> + *
> + * field An event_field instance.
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_event_field(struct mi_writer *writer,
> +		struct lttng_event_field *field);
> +
> +/*
> + * Machine interface: open a event_fields element.
> + *
> + * writer An instance of a machine interface writer
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_event_fields_open(struct mi_writer *writer);
> +
> +/*
> + * Machine interface: open a pids element.
> + *
> + * writer An instance of a machine interface writer
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_pids_open(struct mi_writer *writer);
> +
> +/*
> + * Machine interface of a pid.
> + *
> + * writer An instance of a machine interface writer
> + *
> + * pid A pid
> + *
> + * is_open Define if we close the pid element
> + *         This should be used carefully and the client
> + *         need to close the pid element.
> + *         Use case: nested addition information on a domain
> + *                  ex: channel event.
> + *         0-> False
> + *         1-> True
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_pid(struct mi_writer *writer, pid_t pid , const char *cmdli=
ne,
> +		int is_open);
> =20
>  #endif /* _MI_LTTNG_H */
> --=20
> 1.9.1
>=20

> From 72a6be5b35ed54aeec90a602683a7431618f56e0 Mon Sep 17 00:00:00 2001
> From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
> Date: Wed, 16 Apr 2014 17:03:31 -0400
> Subject: [PATCH 2/5] Mi: support for command list
>=20
> Signed-off-by: Jonathan Rajotte <jonathan.r.julien@gmail.com>
> ---
>  src/bin/lttng/commands/list.c | 1031 ++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 801 insertions(+), 230 deletions(-)
>=20
> diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
> index bbd674c..355375a 100644
> --- a/src/bin/lttng/commands/list.c
> +++ b/src/bin/lttng/commands/list.c
> @@ -23,6 +23,8 @@
>  #include <string.h>
>  #include <assert.h>
> =20
> +#include <common/mi-lttng.h>
> +
>  #include "../command.h"
> =20
>  static int opt_userspace;
> @@ -48,6 +50,7 @@ enum {
>  };
> =20
>  static struct lttng_handle *handle;
> +static struct mi_writer *writer;
> =20
>  static struct poptOption long_options[] =3D {
>  	/* longName, shortName, argInfo, argPtr, value, descrip, argDesc */
> @@ -177,46 +180,6 @@ const char *exclusion_string(int value)
>  	}
>  }
> =20
> -static const char *loglevel_string(int value)
> -{
> -	switch (value) {
> -	case -1:
> -		return "";
> -	case LTTNG_LOGLEVEL_EMERG:
> -		return "TRACE_EMERG";
> -	case LTTNG_LOGLEVEL_ALERT:
> -		return "TRACE_ALERT";
> -	case LTTNG_LOGLEVEL_CRIT:
> -		return "TRACE_CRIT";
> -	case LTTNG_LOGLEVEL_ERR:
> -		return "TRACE_ERR";
> -	case LTTNG_LOGLEVEL_WARNING:
> -		return "TRACE_WARNING";
> -	case LTTNG_LOGLEVEL_NOTICE:
> -		return "TRACE_NOTICE";
> -	case LTTNG_LOGLEVEL_INFO:
> -		return "TRACE_INFO";
> -	case LTTNG_LOGLEVEL_DEBUG_SYSTEM:
> -		return "TRACE_DEBUG_SYSTEM";
> -	case LTTNG_LOGLEVEL_DEBUG_PROGRAM:
> -		return "TRACE_DEBUG_PROGRAM";
> -	case LTTNG_LOGLEVEL_DEBUG_PROCESS:
> -		return "TRACE_DEBUG_PROCESS";
> -	case LTTNG_LOGLEVEL_DEBUG_MODULE:
> -		return "TRACE_DEBUG_MODULE";
> -	case LTTNG_LOGLEVEL_DEBUG_UNIT:
> -		return "TRACE_DEBUG_UNIT";
> -	case LTTNG_LOGLEVEL_DEBUG_FUNCTION:
> -		return "TRACE_DEBUG_FUNCTION";
> -	case LTTNG_LOGLEVEL_DEBUG_LINE:
> -		return "TRACE_DEBUG_LINE";
> -	case LTTNG_LOGLEVEL_DEBUG:
> -		return "TRACE_DEBUG";
> -	default:
> -		return "<<UNKNOWN>>";
> -	}
> -}
> -
>  static const char *logleveltype_string(enum lttng_loglevel_type value)
>  {
>  	switch (value) {
> @@ -244,7 +207,7 @@ static void print_events(struct lttng_event *event)
>  				indent6,
>  				event->name,
>  				logleveltype_string(event->loglevel_type),
> -				loglevel_string(event->loglevel),
> +				mi_lttng_loglevel_string(event->loglevel),
>  				event->loglevel,
>  				enabled_string(event->enabled),
>  				exclusion_string(event->exclusion),
> @@ -333,9 +296,91 @@ static void print_event_field(struct lttng_event_fie=
ld *field)
>  		field_type(field), field->nowrite ? " [no write]" : "");
>  }
> =20
> +/*
> + * Machine interface
> + * Jul and ust event listing
> + */
> +static int mi_list_jul_ust_events(struct lttng_event *events, int count,
> +		struct lttng_domain *domain)
> +{
> +	int ret, i;
> +	pid_t cur_pid =3D 0;
> +	char *cmdline =3D NULL;
> +	int pid_element_open =3D 0;
> +
> +	/* Open domains element */
> +	ret =3D mi_lttng_domains_open(writer);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Write domain */
> +	ret =3D mi_lttng_domain(writer, domain, 1);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Open pids element */
> +	ret =3D mi_lttng_pids_open(writer);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	for (i =3D 0; i < count; i++) {
> +		if (cur_pid !=3D events[i].pid) {
> +			if (pid_element_open) {
> +				/* Close the previous envents and  pid element */
> +				ret =3D mi_lttng_close_multi_element(writer, 2);
> +				if (ret) {
> +					goto end;
> +				}
> +				pid_element_open =3D !pid_element_open;
> +			}
> +
> +			cur_pid =3D events[i].pid;
> +			cmdline =3D get_cmdline_by_pid(cur_pid);
> +
> +			if (!pid_element_open) {
> +				/* Open and write a pid elemen */
> +				ret =3D mi_lttng_pid(writer, cur_pid, cmdline, 1);
> +				if (ret) {
> +					goto error;
> +				}
> +
> +				/* Open events element */
> +				ret =3D mi_lttng_events_open(writer);
> +				if (ret) {
> +					goto error;
> +				}
> +
> +				pid_element_open =3D !pid_element_open;
> +			}
> +			free(cmdline);
> +		}
> +
> +		/* Write an event */
> +		ret =3D mi_lttng_event(writer, &events[i], 0);
> +		if (ret) {
> +			goto end;
> +		}
> +	}
> +
> +
> +	/* Close pids */
> +	ret =3D mi_lttng_writer_close_element(writer);
> +
> +	/* Close domain, domains */
> +	ret =3D mi_lttng_close_multi_element(writer, 2);
> +end:
> +	return ret;
> +error:
> +	free(cmdline);
> +	return ret;
> +}
> +
>  static int list_jul_events(void)
>  {
> -	int i, size;
> +	int i, size, ret =3D CMD_SUCCESS;
>  	struct lttng_domain domain;
>  	struct lttng_handle *handle;
>  	struct lttng_event *event_list;
> @@ -349,42 +394,45 @@ static int list_jul_events(void)
> =20
>  	handle =3D lttng_create_handle(NULL, &domain);
>  	if (handle =3D=3D NULL) {
> +		ret =3D -1;
>  		goto error;
>  	}
> =20
>  	size =3D lttng_list_tracepoints(handle, &event_list);
>  	if (size < 0) {
>  		ERR("Unable to list JUL events: %s", lttng_strerror(size));
> -		lttng_destroy_handle(handle);
> -		return size;
> +		ret =3D size;
> +		goto error;
>  	}
> =20
> -	MSG("JUL events (Logger name):\n-------------------------");
> -
> -	if (size =3D=3D 0) {
> -		MSG("None");
> -	}
> +	if (lttng_opt_mi) {
> +		/* Mi print */
> +		ret =3D mi_list_jul_ust_events(event_list, size, &domain);
> +	} else {
> +		/* Pretty print */
> +		MSG("JUL events (Logger name):\n-------------------------");
> =20
> -	for (i =3D 0; i < size; i++) {
> -		if (cur_pid !=3D event_list[i].pid) {
> -			cur_pid =3D event_list[i].pid;
> -			cmdline =3D get_cmdline_by_pid(cur_pid);
> -			MSG("\nPID: %d - Name: %s", cur_pid, cmdline);
> -			free(cmdline);
> +		if (size =3D=3D 0) {
> +			MSG("None");
>  		}
> -		MSG("%s- %s", indent6, event_list[i].name);
> -	}
> =20
> -	MSG("");
> +		for (i =3D 0; i < size; i++) {
> +			if (cur_pid !=3D event_list[i].pid) {
> +				cur_pid =3D event_list[i].pid;
> +				cmdline =3D get_cmdline_by_pid(cur_pid);
> +				MSG("\nPID: %d - Name: %s", cur_pid, cmdline);
> +				free(cmdline);
> +			}
> +			MSG("%s- %s", indent6, event_list[i].name);
> +		}
> =20
> +		MSG("");
> +	}
>  	free(event_list);
> -	lttng_destroy_handle(handle);
> -
> -	return CMD_SUCCESS;
> =20
>  error:
>  	lttng_destroy_handle(handle);
> -	return -1;
> +	return ret;
>  }
> =20
>  /*
> @@ -392,7 +440,7 @@ error:
>   */
>  static int list_ust_events(void)
>  {
> -	int i, size;
> +	int i, size, ret =3D CMD_SUCCESS;
>  	struct lttng_domain domain;
>  	struct lttng_handle *handle;
>  	struct lttng_event *event_list;
> @@ -407,42 +455,162 @@ static int list_ust_events(void)
> =20
>  	handle =3D lttng_create_handle(NULL, &domain);
>  	if (handle =3D=3D NULL) {
> +		ret =3D -1;
>  		goto error;
>  	}
> =20
>  	size =3D lttng_list_tracepoints(handle, &event_list);
>  	if (size < 0) {
>  		ERR("Unable to list UST events: %s", lttng_strerror(size));
> -		lttng_destroy_handle(handle);
> -		return size;
> +		ret =3D size;
> +		goto error;
>  	}
> =20
> -	MSG("UST events:\n-------------");
> +	if (lttng_opt_mi) {
> +		/* Mi print */
> +		ret =3D mi_list_jul_ust_events(event_list, size, &domain);
> +	} else {
> +		/* Pretty print */
> +		MSG("UST events:\n-------------");
> +
> +		if (size =3D=3D 0) {
> +			MSG("None");
> +		}
> +
> +		for (i =3D 0; i < size; i++) {
> +			if (cur_pid !=3D event_list[i].pid) {
> +				cur_pid =3D event_list[i].pid;
> +				cmdline =3D get_cmdline_by_pid(cur_pid);
> +				MSG("\nPID: %d - Name: %s", cur_pid, cmdline);
> +				free(cmdline);
> +			}
> +			print_events(&event_list[i]);
> +		}
> =20
> -	if (size =3D=3D 0) {
> -		MSG("None");
> +		MSG("");
>  	}
> +	free(event_list);
> +
> +error:
> +	lttng_destroy_handle(handle);
> +	return ret;
> +}
> +
> +/*
> + * Machine interface
> + * List all ust event with their fields
> + */
> +static int mi_list_ust_event_fields(struct lttng_event_field *fields, in=
t count,
> +		struct lttng_domain *domain)
> +{
> +	int ret, i;
> +	pid_t cur_pid =3D 0;
> +	char *cmdline =3D NULL;
> +	int pid_element_open =3D 0;
> +	int event_element_open =3D 0;
> =20
> -	for (i =3D 0; i < size; i++) {
> -		if (cur_pid !=3D event_list[i].pid) {
> -			cur_pid =3D event_list[i].pid;
> +	struct lttng_event cur_event;
> +
> +	/* Open domains element */
> +	ret =3D mi_lttng_domains_open(writer);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Write domain */
> +	ret =3D mi_lttng_domain(writer, domain, 1);
> +
> +	/* Open pids element */
> +	ret =3D mi_lttng_pids_open(writer);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	for (i =3D 0; i < count; i++) {
> +		if (cur_pid !=3D fields[i].event.pid) {
> +			if (pid_element_open) {
> +				if (event_element_open) {
> +					/* Close the previous fields element
> +					 * and the previous event
> +					 */
> +					ret =3D mi_lttng_close_multi_element(writer, 2);
> +					if (ret) {
> +						goto end;
> +					}
> +					event_element_open =3D !event_element_open ;
> +				}
> +				/* Close the previous events, pid element */
> +				ret =3D mi_lttng_close_multi_element(writer, 2);
> +				if (ret) {
> +					goto end;
> +				}
> +				pid_element_open =3D !pid_element_open;
> +			}
> +
> +			cur_pid =3D fields[i].event.pid;
>  			cmdline =3D get_cmdline_by_pid(cur_pid);
> -			MSG("\nPID: %d - Name: %s", cur_pid, cmdline);
> +			if (!pid_element_open) {
> +				/* Open and write a pid elemen */
> +				ret =3D mi_lttng_pid(writer, cur_pid, cmdline, 1);
> +				if (ret) {
> +					goto error;
> +				}
> +
> +				/* Open events element */
> +				ret =3D mi_lttng_events_open(writer);
> +				if (ret) {
> +					goto error;
> +				}
> +				pid_element_open =3D !pid_element_open;
> +			}
>  			free(cmdline);
> +			/* Wipe current event since we are about to print a new PID. */
> +			memset(&cur_event, 0, sizeof(cur_event));
>  		}
> -		print_events(&event_list[i]);
> -	}
> =20
> -	MSG("");
> +		if (strcmp(cur_event.name, fields[i].event.name) !=3D 0) {
> +			if (event_element_open) {
> +				/* Close the previous fields element and the previous event */
> +				ret =3D mi_lttng_close_multi_element(writer, 2);
> +				if (ret) {
> +					goto end;
> +				}
> +				event_element_open =3D !event_element_open ;
> +			}
> =20
> -	free(event_list);
> -	lttng_destroy_handle(handle);
> +			memcpy(&cur_event, &fields[i].event,
> +					sizeof(cur_event));
> =20
> -	return CMD_SUCCESS;
> +			if (!event_element_open) {
> +				/* Open and write the event */
> +				ret =3D mi_lttng_event(writer, &cur_event, 1);
> +				if (ret) {
> +					goto end;
> +				}
> +
> +				/* Open a fields element */
> +				ret =3D mi_lttng_event_fields_open(writer);
> +				if (ret) {
> +					goto end;
> +				}
> +				event_element_open =3D !event_element_open ;
> +			}
> +		}
> =20
> +		/* Print the event_field */
> +		ret =3D mi_lttng_event_field(writer, &fields[i]);
> +		if (ret) {
> +			goto end;
> +		}
> +	}
> +
> +	/* Close pids, domain, domains */
> +	ret =3D mi_lttng_close_multi_element(writer, 3);
> +end:
> +	return ret;
>  error:
> -	lttng_destroy_handle(handle);
> -	return -1;
> +	free(cmdline);
> +	return ret;
>  }
> =20
>  /*
> @@ -450,7 +618,7 @@ error:
>   */
>  static int list_ust_event_fields(void)
>  {
> -	int i, size;
> +	int i, size, ret =3D CMD_SUCCESS;
>  	struct lttng_domain domain;
>  	struct lttng_handle *handle;
>  	struct lttng_event_field *event_field_list;
> @@ -468,57 +636,104 @@ static int list_ust_event_fields(void)
> =20
>  	handle =3D lttng_create_handle(NULL, &domain);
>  	if (handle =3D=3D NULL) {
> +		ret =3D -1;
>  		goto error;
>  	}
> =20
>  	size =3D lttng_list_tracepoint_fields(handle, &event_field_list);
>  	if (size < 0) {
>  		ERR("Unable to list UST event fields: %s", lttng_strerror(size));
> -		lttng_destroy_handle(handle);
> -		return size;
> +		ret =3D size;
> +		goto error;
>  	}
> =20
> -	MSG("UST events:\n-------------");
> -
> -	if (size =3D=3D 0) {
> -		MSG("None");
> -	}
> +	if (lttng_opt_mi) {
> +		/* Mi print */
> +		ret =3D mi_list_ust_event_fields(event_field_list, size, &domain);
> +	} else {
> +		/* Pretty print */
> +		MSG("UST events:\n-------------");
> =20
> -	for (i =3D 0; i < size; i++) {
> -		if (cur_pid !=3D event_field_list[i].event.pid) {
> -			cur_pid =3D event_field_list[i].event.pid;
> -			cmdline =3D get_cmdline_by_pid(cur_pid);
> -			MSG("\nPID: %d - Name: %s", cur_pid, cmdline);
> -			free(cmdline);
> -			/* Wipe current event since we are about to print a new PID. */
> -			memset(&cur_event, 0, sizeof(cur_event));
> +		if (size =3D=3D 0) {
> +			MSG("None");
>  		}
> -		if (strcmp(cur_event.name, event_field_list[i].event.name) !=3D 0) {
> -			print_events(&event_field_list[i].event);
> -			memcpy(&cur_event, &event_field_list[i].event,
> -				sizeof(cur_event));
> -		}
> -		print_event_field(&event_field_list[i]);
> -	}
> =20
> -	MSG("");
> +		for (i =3D 0; i < size; i++) {
> +			if (cur_pid !=3D event_field_list[i].event.pid) {
> +				cur_pid =3D event_field_list[i].event.pid;
> +				cmdline =3D get_cmdline_by_pid(cur_pid);
> +				MSG("\nPID: %d - Name: %s", cur_pid, cmdline);
> +				free(cmdline);
> +				/* Wipe current event since we are about to print a new PID. */
> +				memset(&cur_event, 0, sizeof(cur_event));
> +			}
> +			if (strcmp(cur_event.name, event_field_list[i].event.name) !=3D 0) {
> +				print_events(&event_field_list[i].event);
> +				memcpy(&cur_event, &event_field_list[i].event,
> +						sizeof(cur_event));
> +			}
> +			print_event_field(&event_field_list[i]);
> +		}
> =20
> +		MSG("");
> +	}
>  	free(event_field_list);
> -	lttng_destroy_handle(handle);
> -
> -	return CMD_SUCCESS;
> =20
>  error:
>  	lttng_destroy_handle(handle);
> -	return -1;
> +	return ret;
>  }
> =20
>  /*
> - * Ask for all trace events in the kernel and pretty print them.
> + * Machine interface
> + * Print a list of kernel events
> + */
> +static int mi_list_kernel_events(struct lttng_event *events, int count,
> +		struct lttng_domain *domain)
> +{
> +	int ret, i;
> +
> +	/* Open domains element */
> +	ret =3D mi_lttng_domains_open(writer);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Write domain */
> +	ret =3D mi_lttng_domain(writer, domain, 1);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Open events */
> +	ret =3D mi_lttng_events_open(writer);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	for (i =3D 0; i < count; i++) {
> +		mi_lttng_event(writer, &events[i], 0);
> +		if (ret) {
> +			goto end;
> +		}
> +	}
> +
> +	/* close events, domain and domains */
> +	ret =3D mi_lttng_close_multi_element(writer, 3);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +end:
> +	return ret;
> +}
> +
> +/*
> + * Ask for all trace events in the kernel
>   */
>  static int list_kernel_events(void)
>  {
> -	int i, size;
> +	int i, size, ret =3D CMD_SUCCESS;
>  	struct lttng_domain domain;
>  	struct lttng_handle *handle;
>  	struct lttng_event *event_list;
> @@ -541,18 +756,27 @@ static int list_kernel_events(void)
>  		return size;
>  	}
> =20
> -	MSG("Kernel events:\n-------------");
> +	if (lttng_opt_mi) {
> +		/* Mi print */
> +		ret =3D mi_list_kernel_events(event_list, size, &domain);
> +		if (ret) {
> +			goto end;
> +		}
> +	} else {
> +		MSG("Kernel events:\n-------------");
> =20
> -	for (i =3D 0; i < size; i++) {
> -		print_events(&event_list[i]);
> -	}
> +		for (i =3D 0; i < size; i++) {
> +			print_events(&event_list[i]);
> +		}
> =20
> -	MSG("");
> +		MSG("");
> +	}
> =20
> +end:
>  	free(event_list);
> =20
>  	lttng_destroy_handle(handle);
> -	return CMD_SUCCESS;
> +	return ret;
> =20
>  error:
>  	lttng_destroy_handle(handle);
> @@ -560,13 +784,41 @@ error:
>  }
> =20
>  /*
> + * Machine Interface
> + * Print a list of jul events
> + */
> +static int mi_list_session_jul_events(struct lttng_event *events, int co=
unt)
> +{
> +	int ret, i;
> +
> +	/* Open events element */
> +	ret =3D mi_lttng_events_open(writer);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	for (i =3D 0; i < count; i++) {
> +		ret =3D mi_lttng_event(writer, &events[i], 0);
> +		if (ret) {
> +			goto end;
> +		}
> +	}
> +
> +	/* Close events element */
> +	ret =3D mi_lttng_writer_close_element(writer);
> +
> +end:
> +	return ret;
> +}
> +
> +/*
>   * List JUL events for a specific session using the handle.
>   *
>   * Return CMD_SUCCESS on success else a negative value.
>   */
>  static int list_session_jul_events(void)
>  {
> -	int ret, count, i;
> +	int ret =3D CMD_SUCCESS, count, i;
>  	struct lttng_event *events =3D NULL;
> =20
>  	count =3D lttng_list_events(handle, "", &events);
> @@ -576,24 +828,56 @@ static int list_session_jul_events(void)
>  		goto error;
>  	}
> =20
> -	MSG("Events (Logger name):\n---------------------");
> -	if (count =3D=3D 0) {
> -		MSG("%sNone\n", indent6);
> +	if (lttng_opt_mi) {
> +		/* Mi print */
> +		ret =3D mi_list_session_jul_events(events, count);
> +	} else {
> +		/* Pretty print */
> +		MSG("Events (Logger name):\n---------------------");
> +		if (count =3D=3D 0) {
> +			MSG("%sNone\n", indent6);
> +			goto end;
> +		}
> +
> +		for (i =3D 0; i < count; i++) {
> +			MSG("%s- %s%s", indent4, events[i].name,
> +					enabled_string(events[i].enabled));
> +		}
> +
> +		MSG("");
> +	}
> +
> +end:
> +	free(events);
> +error:
> +	return ret;
> +}
> +
> +/*
> + * Machine interface
> + * print a list of event
> + */
> +static int mi_list_events(struct lttng_event *events, int count)
> +{
> +	int ret, i;
> +
> +	/* Open events element */
> +	ret =3D mi_lttng_events_open(writer);
> +	if (ret) {
>  		goto end;
>  	}
> =20
>  	for (i =3D 0; i < count; i++) {
> -		MSG("%s- %s%s", indent4, events[i].name,
> -				enabled_string(events[i].enabled));
> +		ret =3D mi_lttng_event(writer, &events[i], 0);
> +		if (ret) {
> +			goto end;
> +		}
>  	}
> =20
> -	MSG("");
> +	/* Close events element */
> +	ret =3D mi_lttng_writer_close_element(writer);
> =20
>  end:
> -	free(events);
> -	ret =3D CMD_SUCCESS;
> -
> -error:
>  	return ret;
>  }
> =20
> @@ -602,7 +886,7 @@ error:
>   */
>  static int list_events(const char *channel_name)
>  {
> -	int ret, count, i;
> +	int ret =3D CMD_SUCCESS, count, i;
>  	struct lttng_event *events =3D NULL;
> =20
>  	count =3D lttng_list_events(handle, channel_name, &events);
> @@ -612,22 +896,25 @@ static int list_events(const char *channel_name)
>  		goto error;
>  	}
> =20
> -	MSG("\n%sEvents:", indent4);
> -	if (count =3D=3D 0) {
> -		MSG("%sNone\n", indent6);
> -		goto end;
> -	}
> -
> -	for (i =3D 0; i < count; i++) {
> -		print_events(&events[i]);
> -	}
> +	if (lttng_opt_mi) {
> +		/* Mi print */
> +		ret =3D mi_list_events(events, count);
> +	} else {
> +		/* Pretty print */
> +		MSG("\n%sEvents:", indent4);
> +		if (count =3D=3D 0) {
> +			MSG("%sNone\n", indent6);
> +			goto end;
> +		}
> =20
> -	MSG("");
> +		for (i =3D 0; i < count; i++) {
> +			print_events(&events[i]);
> +		}
> =20
> +		MSG("");
> +	}
>  end:
>  	free(events);
> -	ret =3D CMD_SUCCESS;
> -
>  error:
>  	return ret;
>  }
> @@ -656,6 +943,62 @@ static void print_channel(struct lttng_channel *chan=
nel)
>  }
> =20
>  /*
> + * Machine interface
> + * Print a list of channel
> + *
> + */
> +static int mi_list_channels(struct lttng_channel *channels, int count,
> +		const char *channel_name)
> +{
> +	int i, ret;
> +	unsigned int chan_found =3D 0;
> +
> +	/* Open channels element */
> +	ret =3D mi_lttng_channels_open(writer);
> +	if (ret) {
> +		goto error;
> +	}
> +
> +	for (i =3D 0; i < count; i++) {
> +		if (channel_name !=3D NULL) {
> +			if (strncmp(channels[i].name, channel_name, NAME_MAX) =3D=3D 0) {
> +				chan_found =3D 1;
> +			} else {
> +				continue;
> +			}
> +		}
> +
> +		/* Write channel element  and leave it open */
> +		ret =3D mi_lttng_channel(writer, &channels[i], 1);
> +
> +		/* Listing events per channel */
> +		ret =3D list_events(channels[i].name);
> +		if (ret) {
> +			goto error;
> +		}
> +
> +		/* Closing the channel element we opened earlier */
> +		ret =3D mi_lttng_writer_close_element(writer);
> +		if (ret) {
> +			goto error;
> +		}
> +
> +		if (chan_found) {
> +			break;
> +		}
> +	}
> +
> +	/* Close channels element */
> +	ret =3D mi_lttng_writer_close_element(writer);
> +	if (ret) {
> +		goto error;
> +	}
> +
> +error:
> +	return ret;
> +}
> +
> +/*
>   * List channel(s) of session and domain.
>   *
>   * If channel_name is NULL, all channels are listed.
> @@ -672,54 +1015,136 @@ static int list_channels(const char *channel_name)
>  	if (count < 0) {
>  		switch (-count) {
>  		case LTTNG_ERR_KERN_CHAN_NOT_FOUND:
> -			ret =3D CMD_SUCCESS;
> -			WARN("No kernel channel");
> +			if (lttng_opt_mi) {
> +				/* When printing mi this is not an error
> +				 * but an empty channels element */
> +				count =3D 0;
> +			} else {
> +				ret =3D CMD_SUCCESS;
> +				WARN("No kernel channel");
> +				goto error_channels;
> +			}
>  			break;
>  		default:
>  			/* We had a real error */
>  			ret =3D count;
>  			ERR("%s", lttng_strerror(ret));
> +			goto error_channels;
>  			break;
>  		}
> -		goto error_channels;
>  	}
> =20
> -	if (channel_name =3D=3D NULL) {
> -		MSG("Channels:\n-------------");
> -	}
> +	if (lttng_opt_mi) {
> +		/* Mi print */
> +		ret =3D mi_list_channels(channels, count, channel_name);
> +	} else {
> +		/* Pretty print */
> +		if (channel_name =3D=3D NULL) {
> +			MSG("Channels:\n-------------");
> +		}
> =20
> -	for (i =3D 0; i < count; i++) {
> -		if (channel_name !=3D NULL) {
> -			if (strncmp(channels[i].name, channel_name, NAME_MAX) =3D=3D 0) {
> -				chan_found =3D 1;
> -			} else {
> -				continue;
> +		for (i =3D 0; i < count; i++) {
> +			if (channel_name !=3D NULL) {
> +				if (strncmp(channels[i].name, channel_name, NAME_MAX) =3D=3D 0) {
> +					chan_found =3D 1;
> +				} else {
> +					continue;
> +				}
>  			}
> -		}
> -		print_channel(&channels[i]);
> +			print_channel(&channels[i]);
> =20
> -		/* Listing events per channel */
> -		ret =3D list_events(channels[i].name);
> -		if (ret < 0) {
> -			ERR("%s", lttng_strerror(ret));
> +			/* Listing events per channel */
> +			ret =3D list_events(channels[i].name);
> +			if (ret < 0) {
> +				ERR("%s", lttng_strerror(ret));
> +				goto error;
> +			}
> +
> +			if (chan_found) {
> +				break;
> +			}
>  		}
> =20
> -		if (chan_found) {
> -			break;
> +		if (!chan_found && channel_name !=3D NULL) {
> +			ERR("Channel %s not found", channel_name);
> +			goto error;
>  		}
>  	}
> +error:
> +	free(channels);
> =20
> -	if (!chan_found && channel_name !=3D NULL) {
> -		ERR("Channel %s not found", channel_name);
> -		goto error;
> +error_channels:
> +	return ret;
> +}
> +
> +/*
> + * Machine interface
> + * Find the session with session_name as name
> + * and print his informations.
> + */
> +static int mi_list_session(const char *session_name,
> +		struct lttng_session *sessions, int count)
> +{
> +	int ret, i;
> +	unsigned int session_found =3D 0;
> +
> +	if (session_name =3D=3D NULL) {
> +		ret =3D -LTTNG_ERR_SESS_NOT_FOUND;
> +		goto end;
> +	}
> +
> +	for (i =3D 0; i < count; i++) {
> +			if (strncmp(sessions[i].name, session_name, NAME_MAX) =3D=3D 0) {
> +				/* We need to leave it open to append other informations
> +				 * like domain, channel, events etc.*/
> +				session_found =3D 1;
> +				ret =3D mi_lttng_session(writer, &sessions[i], 1);
> +				if (ret) {
> +					goto end;
> +				}
> +				break;
> +			}
>  	}
> =20
> -	ret =3D CMD_SUCCESS;
> +	if (!session_found) {
> +		ERR("Session not found");
> +		ret =3D -LTTNG_ERR_SESS_NOT_FOUND;
> +		goto end;
> +	}
> =20
> -error:
> -	free(channels);
> +end:
> +	return ret;
> +}
> =20
> -error_channels:
> +/*
> + * Machine interface
> + * List all availables session
> + */
> +static int mi_list_sessions(struct lttng_session *sessions, int count)
> +{
> +	int ret, i;
> +
> +	/* Opening sessions element */
> +	ret =3D mi_lttng_sessions_open(writer);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Listing sessions */
> +	for (i =3D 0; i < count; i++) {
> +		ret =3D mi_lttng_session(writer, &sessions[i], 0);
> +		if (ret) {
> +			goto end;
> +		}
> +	}
> +
> +	/* Closing sessions element */
> +	ret =3D mi_lttng_writer_close_element(writer);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +end:
>  	return ret;
>  }
> =20
> @@ -730,7 +1155,8 @@ error_channels:
>   */
>  static int list_sessions(const char *session_name)
>  {
> -	int ret, count, i;
> +	int ret =3D CMD_SUCCESS;
> +	int count, i;
>  	unsigned int session_found =3D 0;
>  	struct lttng_session *sessions;
> =20
> @@ -740,48 +1166,85 @@ static int list_sessions(const char *session_name)
>  		ret =3D count;
>  		ERR("%s", lttng_strerror(ret));
>  		goto error;
> -	} else if (count =3D=3D 0) {
> -		MSG("Currently no available tracing session");
> -		goto end;
>  	}
> =20
> -	if (session_name =3D=3D NULL) {
> -		MSG("Available tracing sessions:");
> -	}
> +	if (lttng_opt_mi) {
> +		/* Mi */
> +		if (session_name =3D=3D NULL) {
> +			/* List all session */
> +			ret =3D mi_list_sessions(sessions, count);
> +		} else {
> +			/* Note : this return an open session element */
> +			ret =3D mi_list_session(session_name, sessions, count);
> +		}
> +	} else {
> +		/* Pretty print */
> +		if (count =3D=3D 0) {
> +			MSG("Currently no available tracing session");
> +			goto end;
> +		}
> =20
> -	for (i =3D 0; i < count; i++) {
> -		if (session_name !=3D NULL) {
> -			if (strncmp(sessions[i].name, session_name, NAME_MAX) =3D=3D 0) {
> -				session_found =3D 1;
> -				MSG("Tracing session %s: [%s%s]", session_name,
> +		if (session_name =3D=3D NULL) {
> +			MSG("Available tracing sessions:");
> +		}
> +
> +
> +		for (i =3D 0; i < count; i++) {
> +			if (session_name !=3D NULL) {
> +				if (strncmp(sessions[i].name, session_name, NAME_MAX) =3D=3D 0) {
> +					session_found =3D 1;
> +					MSG("Tracing session %s: [%s%s]", session_name,
> +							active_string(sessions[i].enabled),
> +							snapshot_string(sessions[i].snapshot_mode));
> +					MSG("%sTrace path: %s\n", indent4, sessions[i].path);
> +					break;
> +				}
> +			} else {
> +				MSG("  %d) %s (%s) [%s%s]", i + 1,
> +						sessions[i].name, sessions[i].path,
>  						active_string(sessions[i].enabled),
>  						snapshot_string(sessions[i].snapshot_mode));
> -				MSG("%sTrace path: %s\n", indent4, sessions[i].path);
> -				break;
>  			}
> -		} else {
> -			MSG("  %d) %s (%s) [%s%s]", i + 1, sessions[i].name, sessions[i].path,
> -					active_string(sessions[i].enabled),
> -					snapshot_string(sessions[i].snapshot_mode));
> +		}
> +
> +		if (!session_found && session_name !=3D NULL) {
> +			ERR("Session '%s' not found", session_name);
> +			ret =3D CMD_ERROR;
> +			goto error;
> +		}
> +
> +		if (session_name =3D=3D NULL) {
> +			MSG("\nUse lttng list <session_name> for more details");
>  		}
>  	}
> =20
> +error:
>  	free(sessions);
> +end:
> +	return ret;
> +}
> =20
> -	if (!session_found && session_name !=3D NULL) {
> -		ERR("Session '%s' not found", session_name);
> -		ret =3D CMD_ERROR;
> -		goto error;
> +
> +/*
> + * Machine Interface
> + * list available domain(s) for a session.
> + */
> +static int mi_list_domains(struct lttng_domain *domains, int count)
> +{
> +	int i, ret;
> +	/* Open domains element */
> +	ret =3D mi_lttng_domains_open(writer);
> +	if (ret) {
> +		goto end;
>  	}
> =20
> -	if (session_name =3D=3D NULL) {
> -		MSG("\nUse lttng list <session_name> for more details");
> +	for (i =3D 0; i < count; i++) {
> +		ret =3D mi_lttng_domain(writer, &domains[i] , 0);
>  	}
> =20
> +	/* Closing domains element */
> +	ret =3D mi_lttng_writer_close_element(writer);
>  end:
> -	return CMD_SUCCESS;
> -
> -error:
>  	return ret;
>  }
> =20
> @@ -793,31 +1256,39 @@ static int list_domains(const char *session_name)
>  	int i, count, ret =3D CMD_SUCCESS;
>  	struct lttng_domain *domains =3D NULL;
> =20
> -	MSG("Domains:\n-------------");
> =20
>  	count =3D lttng_list_domains(session_name, &domains);
>  	if (count < 0) {
>  		ret =3D count;
>  		ERR("%s", lttng_strerror(ret));
>  		goto error;
> -	} else if (count =3D=3D 0) {
> -		MSG("  None");
> -		goto end;
>  	}
> =20
> -	for (i =3D 0; i < count; i++) {
> -		switch (domains[i].type) {
> -		case LTTNG_DOMAIN_KERNEL:
> -			MSG("  - Kernel");
> -			break;
> -		case LTTNG_DOMAIN_UST:
> -			MSG("  - UST global");
> -			break;
> -		case LTTNG_DOMAIN_JUL:
> -			MSG("  - JUL (Java Util Logging)");
> -			break;
> -		default:
> -			break;
> +	if (lttng_opt_mi) {
> +		/* Mi output */
> +		ret =3D mi_list_domains(domains, count);
> +	} else {
> +		/* Pretty print */
> +		MSG("Domains:\n-------------");
> +		if (count =3D=3D 0) {
> +			MSG("  None");
> +			goto end;
> +		}
> +
> +		for (i =3D 0; i < count; i++) {
> +			switch (domains[i].type) {
> +			case LTTNG_DOMAIN_KERNEL:
> +				MSG("  - Kernel");
> +				break;
> +			case LTTNG_DOMAIN_UST:
> +				MSG("  - UST global");
> +				break;
> +			case LTTNG_DOMAIN_JUL:
> +				MSG("  - JUL (Java Util Logging)");
> +				break;
> +			default:
> +				break;
> +			}
>  		}
>  	}
> =20
> @@ -850,13 +1321,6 @@ int cmd_list(int argc, const char **argv)
>  	pc =3D poptGetContext(NULL, argc, argv, long_options, 0);
>  	poptReadDefaultConfig(pc, 0);
> =20
> -	/* TODO: mi support */
> -	if (lttng_opt_mi) {
> -		ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> -		ERR("mi option not supported");
> -		goto end;
> -	}
> -
>  	while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
>  		switch (opt) {
>  		case OPT_HELP:
> @@ -875,6 +1339,29 @@ int cmd_list(int argc, const char **argv)
>  		}
>  	}
> =20
> +	/* Mi check */
> +	if (lttng_opt_mi) {
> +		writer =3D mi_lttng_writer_create(fileno(stdout), lttng_opt_mi);
> +		if (!writer) {
> +			ret =3D -LTTNG_ERR_NOMEM;
> +			goto end;
> +		}
> +
> +		/* Open command element */
> +		ret =3D mi_lttng_writer_command_open(writer,
> +				mi_lttng_element_command_list);
> +		if (ret) {
> +			goto end;
> +		}
> +
> +		/* Open output element */
> +		ret =3D mi_lttng_writer_open_element(writer,
> +				mi_lttng_element_command_output);
> +		if (ret) {
> +			goto end;
> +		}
> +	}
> +
>  	/* Get session name (trailing argument) */
>  	session_name =3D poptGetArg(pc);
>  	DBG2("Session name: %s", session_name);
> @@ -900,14 +1387,13 @@ int cmd_list(int argc, const char **argv)
>  	if (session_name =3D=3D NULL) {
>  		if (!opt_kernel && !opt_userspace && !opt_jul) {
>  			ret =3D list_sessions(NULL);
> -			if (ret !=3D 0) {
> +			if (ret) {
>  				goto end;
>  			}
>  		}
>  		if (opt_kernel) {
>  			ret =3D list_kernel_events();
> -			if (ret < 0) {
> -				ret =3D CMD_ERROR;
> +			if (ret) {
>  				goto end;
>  			}
>  		}
> @@ -917,22 +1403,29 @@ int cmd_list(int argc, const char **argv)
>  			} else {
>  				ret =3D list_ust_events();
>  			}
> -			if (ret < 0) {
> -				ret =3D CMD_ERROR;
> +			if (ret) {
>  				goto end;
>  			}
>  		}
>  		if (opt_jul) {
>  			ret =3D list_jul_events();
> -			if (ret < 0) {
> -				ret =3D CMD_ERROR;
> +			if (ret) {
>  				goto end;
>  			}
>  		}
>  	} else {
>  		/* List session attributes */
> +		if (lttng_opt_mi) {
> +			/* Open element sessions
> +			 * Present for xml consistency */
> +			ret =3D mi_lttng_sessions_open(writer);
> +			if (ret) {
> +				goto end;
> +			}
> +		}
> +		/* MI: the ouptut of list_sessions is an unclosed session element */
>  		ret =3D list_sessions(session_name);
> -		if (ret !=3D 0) {
> +		if (ret) {
>  			goto end;
>  		}
> =20
> @@ -942,12 +1435,40 @@ int cmd_list(int argc, const char **argv)
>  			goto end;
>  		}
> =20
> +		/* Channel listing */
>  		if (opt_kernel || opt_userspace) {
> -			/* Channel listing */
> +			if (lttng_opt_mi) {
> +				/* Add of domains and domain element for xml
> +				 * consistency and validation
> +				 */
> +				ret =3D mi_lttng_domains_open(writer);
> +				if (ret) {
> +					goto end;
> +				}
> +
> +				/* Open domain and leave it open for
> +				 * nested channels printing */
> +				ret =3D mi_lttng_domain(writer, &domain, 1);
> +				if (ret) {
> +					goto end;
> +				}
> +
> +			}
> +
>  			ret =3D list_channels(opt_channel);
> -			if (ret < 0) {
> +			if (ret) {
> +				goto end;
> +			}
> +
> +			if (lttng_opt_mi) {
> +				/* Close domain and domain element */
> +				ret =3D mi_lttng_close_multi_element(writer, 2);
> +			}
> +			if (ret) {
>  				goto end;
>  			}
> +
> +
>  		} else {
>  			int i, nb_domain;
> =20
> @@ -959,6 +1480,13 @@ int cmd_list(int argc, const char **argv)
>  				goto end;
>  			}
> =20
> +			if (lttng_opt_mi) {
> +				ret =3D mi_lttng_domains_open(writer);
> +				if (ret) {
> +					goto end;
> +				}
> +			}
> +
>  			for (i =3D 0; i < nb_domain; i++) {
>  				switch (domains[i].type) {
>  				case LTTNG_DOMAIN_KERNEL:
> @@ -978,6 +1506,13 @@ int cmd_list(int argc, const char **argv)
>  					break;
>  				}
> =20
> +				if (lttng_opt_mi) {
> +					ret =3D mi_lttng_domain(writer, &domains[i], 1);
> +					if (ret) {
> +						goto end;
> +					}
> +				}
> +
>  				/* Clean handle before creating a new one */
>  				if (handle) {
>  					lttng_destroy_handle(handle);
> @@ -991,21 +1526,57 @@ int cmd_list(int argc, const char **argv)
> =20
>  				if (domains[i].type =3D=3D LTTNG_DOMAIN_JUL) {
>  					ret =3D list_session_jul_events();
> -					if (ret < 0) {
> +					if (ret) {
>  						goto end;
>  					}
>  					continue;
>  				}
> =20
>  				ret =3D list_channels(opt_channel);
> -				if (ret < 0) {
> +				if (ret) {
> +					goto end;
> +				}
> +
> +				if (lttng_opt_mi) {
> +					/* Close domain element */
> +					ret =3D mi_lttng_writer_close_element(writer);
> +					if (ret) {
> +						goto end;
> +					}
> +				}
> +
> +			}
> +			if (lttng_opt_mi) {
> +				/* Close the domains, session and sessions element */
> +				ret =3D mi_lttng_close_multi_element(writer, 3);
> +				if (ret) {
>  					goto end;
>  				}
>  			}
>  		}
>  	}
> =20
> +	/* Mi closing */
> +	if (lttng_opt_mi) {
> +		/* Close  output element */
> +		ret =3D mi_lttng_writer_close_element(writer);
> +		if (ret) {
> +			goto end;
> +		}
> +
> +		/* Command element close */
> +		ret =3D mi_lttng_writer_command_close(writer);
> +		if (ret) {
> +			goto end;
> +		}
> +	}
>  end:
> +	/* Mi clean-up */
> +	if (writer && mi_lttng_writer_destroy(writer)) {
> +		/* Preserve original error code */
> +		ret =3D ret ? ret : LTTNG_ERR_MI_IO_FAIL;
> +	}
> +
>  	free(domains);
>  	if (handle) {
>  		lttng_destroy_handle(handle);
> --=20
> 1.9.1
>=20

> From f478c2feebbf136bacf571e42054312a01ba6074 Mon Sep 17 00:00:00 2001
> From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
> Date: Wed, 16 Apr 2014 17:14:08 -0400
> Subject: [PATCH 3/5] Mi: mi xsd validation
>=20
> Command list and version supported
>=20
> Signed-off-by: Jonathan Rajotte <jonathan.r.julien@gmail.com>
> ---
>  src/common/mi_lttng.xsd | 320 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 320 insertions(+)
>  create mode 100644 src/common/mi_lttng.xsd
>=20
> diff --git a/src/common/mi_lttng.xsd b/src/common/mi_lttng.xsd
> new file mode 100644
> index 0000000..6fc25c6
> --- /dev/null
> +++ b/src/common/mi_lttng.xsd
> @@ -0,0 +1,320 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8"?>
> +<!--
> +Copyright (c) 2014 - Oliver Cotte <olivier.cotte@polymtl.ca>
> +                   - Jonathan Rajotte <jonathan.r.julien@gmail.com>
> +
> +Permission is hereby granted, free of charge, to any person obtaining a =
copy
> +of this software and associated documentation files (the "Software"), to=
 deal
> +in the Software without restriction, including without limitation the ri=
ghts
> +to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> +copies of the Software, and to permit persons to whom the Software is
> +furnished to do so, subject to the following conditions:
> +
> +The above copyright notice and this permission notice shall be included =
in
> +all copies or substantial portions of the Software.
> +
> +THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS =
OR
> +IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> +FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL =
THE
> +AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> +LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING =
FROM,
> +OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> +THE SOFTWARE.
> +-->
> +<xs:schema xmlns:xs=3D"http://www.w3.org/2001/XMLSchema"
> +	elementFormDefault=3D"qualified" version=3D"2.5">
> +
> +	<!-- Maps to the uint32_t type -->
> +	<xs:simpleType name=3D"uint32_type">
> +		<xs:restriction base=3D"xs:integer">
> +			<xs:minInclusive value=3D"0" />
> +			<xs:maxInclusive value=3D"4294967295" />
> +		</xs:restriction>
> +	</xs:simpleType>
> +
> +	<!-- Maps to the uint64_t type -->
> +	<xs:simpleType name=3D"uint64_type">
> +		<xs:restriction base=3D"xs:integer">
> +			<xs:minInclusive value=3D"0" />
> +			<xs:maxInclusive value=3D"18446744073709551615" />
> +		</xs:restriction>
> +	</xs:simpleType>
> +
> +	<!-- Maps to the char name[LTTNG_SYMBOL_NAME_LEN] -->
> +	<xs:simpleType name=3D"name_type">
> +		<xs:restriction base=3D"xs:string">
> +			<xs:maxLength value=3D"255" />
> +		</xs:restriction>
> +	</xs:simpleType>
> +
> +	<!-- Maps to the lttng_event_type enum -->
> +	<xs:simpleType name=3D"event_type_type">
> +		<xs:restriction base=3D"xs:string">
> +			<xs:enumeration value=3D"ALL" />
> +			<xs:enumeration value=3D"TRACEPOINT" />
> +			<xs:enumeration value=3D"PROBE" />
> +			<xs:enumeration value=3D"FUNCTION" />
> +			<xs:enumeration value=3D"FUNCTION_ENTRY" />
> +			<xs:enumeration value=3D"NOOP" />
> +			<xs:enumeration value=3D"SYSCALL" />
> +			<xs:enumeration value=3D"KPROBE" />
> +			<xs:enumeration value=3D"KRETPROBE" />
> +		</xs:restriction>
> +	</xs:simpleType>
> +
> +	<!-- Maps to the lttng_event_field_type enum -->
> +	<xs:simpleType name=3D"event_field_type_type">
> +		<xs:restriction base=3D"xs:string">
> +			<xs:enumeration value=3D"OTHER" />
> +			<xs:enumeration value=3D"INTEGER" />
> +			<xs:enumeration value=3D"ENUM" />
> +			<xs:enumeration value=3D"FLOAT" />
> +			<xs:enumeration value=3D"STRING" />
> +		</xs:restriction>
> +	</xs:simpleType>
> +
> +	<!-- Maps to the lttng_loglevel_type enum -->
> +	<xs:simpleType name=3D"loglevel_type">
> +		<xs:restriction base=3D"xs:string">
> +			<xs:enumeration value=3D"ALL" />
> +			<xs:enumeration value=3D"RANGE" />
> +			<xs:enumeration value=3D"SINGLE" />
> +			<xs:enumeration value=3D"UNKNOWN" />
> +		</xs:restriction>
> +	</xs:simpleType>
> +
> +	<!-- Maps to loglevel_string char * -->
> +	<xs:simpleType name=3D"loglevel_string_type">
> +		<xs:restriction base=3D"xs:string">
> +			<xs:enumeration value=3D"" />
> +			<xs:enumeration value=3D"TRACE_EMERG" />
> +			<xs:enumeration value=3D"TRACE_ALERT" />
> +			<xs:enumeration value=3D"TRACE_CRIT" />
> +			<xs:enumeration value=3D"TRACE_ERR" />
> +			<xs:enumeration value=3D"TRACE_WARNING" />
> +			<xs:enumeration value=3D"TRACE_NOTICE" />
> +			<xs:enumeration value=3D"TRACE_INFO" />
> +			<xs:enumeration value=3D"TRACE_DEBUG_SYSTEM" />
> +			<xs:enumeration value=3D"TRACE_DEBUG_PROGRAM" />
> +			<xs:enumeration value=3D"TRACE_DEBUG_PROCESS" />
> +			<xs:enumeration value=3D"TRACE_DEBUG_MODULE" />
> +			<xs:enumeration value=3D"TRACE_DEBUG_UNIT" />
> +			<xs:enumeration value=3D"TRACE_DEBUG_FUNCTION" />
> +			<xs:enumeration value=3D"TRACE_DEBUG_LINE" />
> +			<xs:enumeration value=3D"TRACE_DEBUG" />
> +			<xs:enumeration value=3D"UNKNOWN" />
> +		</xs:restriction>
> +	</xs:simpleType>
> +
> +	<!-- Maps to the lttng_event_probe_attr struct -->
> +	<xs:complexType name=3D"event_probe_attributes_type">
> +		<xs:all>
> +			<xs:element name=3D"address" type=3D"uint64_type" />
> +			<xs:element name=3D"offset" type=3D"uint64_type" />
> +			<xs:element name=3D"symbol_name" type=3D"name_type" />
> +		</xs:all>
> +	</xs:complexType>
> +
> +	<!-- Maps to the lttng_event_function_attr struct -->
> +	<xs:complexType name=3D"event_ftrace_attributes_type">
> +		<xs:all>
> +			<xs:element name=3D"symbol_name" type=3D"name_type" />
> +		</xs:all>
> +	</xs:complexType>
> +
> +	<!-- Maps to per event type configuration -->
> +	<xs:complexType name=3D"event_attributes_type">
> +		<xs:choice>
> +			<xs:element name=3D"probe_attributes" type=3D"event_probe_attributes_=
type" />
> +			<xs:element name=3D"function_attributes" type=3D"event_ftrace_attribu=
tes_type" />
> +		</xs:choice>
> +	</xs:complexType>
> +
> +	<!-- Maps to lttng_event struct -->
> +	<xs:complexType name=3D"event_type">
> +		<xs:all>
> +			<xs:element name=3D"type" type=3D"event_type_type" default=3D"TRACEPO=
INT" minOccurs=3D"0" />
> +			<xs:element name=3D"name" type=3D"name_type" minOccurs=3D"0" />
> +			<xs:element name=3D"loglevel_type" type=3D"loglevel_type" default=3D"=
ALL" minOccurs=3D"0" />
> +			<xs:element name=3D"loglevel" type=3D"loglevel_string_type" default=
=3D"" minOccurs=3D"0" />
> +			<xs:element name=3D"enabled" type=3D"xs:boolean" default=3D"false" mi=
nOccurs=3D"0" />
> +			<xs:element name=3D"filter" type=3D"xs:boolean" minOccurs=3D"0" />
> +			<xs:element name=3D"exclusion" type=3D"xs:boolean" minOccurs=3D"0" />
> +			<xs:element name=3D"attributes" type=3D"event_attributes_type" minOcc=
urs=3D"0" />
> +			<xs:element name=3D"event_fields" type=3D"event_fields_type" minOccur=
s=3D"0" />
> +		</xs:all>
> +	</xs:complexType>
> +
> +	<!-- Maps to mi_lttng_version struct -->
> +	<xs:complexType name=3D"version_type">
> +		<xs:all>
> +			<xs:element name=3D"name" type=3D"name_type" />
> +			<xs:element name=3D"string" type=3D"name_type" />
> +			<xs:element name=3D"major" type=3D"uint32_type" />
> +			<xs:element name=3D"url" type=3D"xs:string" />
> +			<xs:element name=3D"minor" type=3D"uint32_type" />
> +			<xs:element name=3D"license" type=3D"xs:string" />
> +			<xs:element name=3D"patchLevel" type=3D"uint32_type" />
> +			<xs:element name=3D"description" type=3D"xs:string" />
> +		</xs:all>
> +	</xs:complexType>
> +
> +	<xs:complexType name=3D"event_list_type">
> +		<xs:sequence>
> +			<xs:element name=3D"event" type=3D"event_type" minOccurs=3D"0" maxOcc=
urs=3D"unbounded" />
> +		</xs:sequence>
> +	</xs:complexType>
> +
> +	<!-- Maps to the lttng_domain_type enum -->
> +	<xs:simpleType name=3D"domain_type_type">
> +		<xs:restriction base=3D"xs:string">
> +			<xs:enumeration value=3D"KERNEL"/>
> +			<xs:enumeration value=3D"UST"/>
> +			<xs:enumeration value=3D"JUL"/>
> +		</xs:restriction>
> +	</xs:simpleType>
> +
> +	<!-- Maps to the lttng_buffer_type enum -->
> +	<xs:simpleType name=3D"domain_buffer_type">
> +		<xs:restriction base=3D"xs:string">
> +			<xs:enumeration value=3D"PER_PID"/>
> +			<xs:enumeration value=3D"PER_UID"/>
> +			<xs:enumeration value=3D"GLOBAL"/>
> +		</xs:restriction>
> +	</xs:simpleType>
> +
> +	<xs:simpleType name=3D"channel_overwrite_mode_type">
> +		<xs:restriction base=3D"xs:string">
> +			<xs:enumeration value=3D"DISCARD" />
> +			<xs:enumeration value=3D"OVERWRITE" />
> +		</xs:restriction>
> +	</xs:simpleType>
> +
> +	<!-- Maps to the lttng_event_output enum -->
> +	<xs:simpleType name=3D"event_output_type">
> +		<xs:restriction base=3D"xs:string">
> +			<xs:enumeration value=3D"SPLICE" />
> +			<xs:enumeration value=3D"MMAP" />
> +		</xs:restriction>
> +	</xs:simpleType>
> +
> +	<xs:complexType name=3D"pid_type">
> +		<xs:all>
> +			<xs:element name=3D"id" type=3D"xs:int"/>
> +			<xs:element name=3D"name" type=3D"name_type"/>
> +			<xs:element name=3D"events" type=3D"event_list_type" minOccurs=3D"0" =
/>
> +		</xs:all>
> +	</xs:complexType>
> +
> +	<xs:complexType name=3D"pids_type">
> +		<xs:sequence>
> +			<xs:element name=3D"pid" type=3D"pid_type" minOccurs=3D"0" maxOccurs=
=3D"unbounded" />
> +		</xs:sequence>
> +	</xs:complexType>
> +
> +	<!-- Maps to struct lttng_domain and contains channels -->
> +	<xs:complexType name=3D"domain_type">
> +		<xs:all>
> +			<xs:element name=3D"type" type=3D"domain_type_type"/>
> +			<xs:element name=3D"buffer_type" type=3D"domain_buffer_type"/>
> +			<xs:element name=3D"pids" type=3D"pids_type" minOccurs=3D"0" />
> +			<xs:element name=3D"channels" type=3D"channels_type" minOccurs=3D"0" =
/>
> +			<xs:element name=3D"events" type=3D"event_list_type" minOccurs=3D"0" =
/>
> +		</xs:all>
> +	</xs:complexType>
> +
> +	<!-- Maps to struct lttng_channel -->
> +	<xs:complexType name=3D"channel_type">
> +		<xs:all>
> +			<xs:element name=3D"name" type=3D"name_type"/>
> +			<xs:element name=3D"enabled" type=3D"xs:boolean" default=3D"true" min=
Occurs=3D"0"/>
> +			<xs:element name=3D"attributes" type=3D"channel_attributes_type" minO=
ccurs=3D"0"/>
> +			<xs:element name=3D"events" type=3D"event_list_type"/>
> +		</xs:all>
> +	</xs:complexType>
> +
> +	<!-- Maps to struct lttng_channel_attr -->
> +	<xs:complexType name=3D"channel_attributes_type">
> +		<xs:all>
> +			<xs:element name=3D"overwrite_mode" type=3D"channel_overwrite_mode_ty=
pe" default=3D"DISCARD" minOccurs=3D"0"/>
> +			<xs:element name=3D"subbuffer_size" type=3D"uint64_type" minOccurs=3D=
"0"/> <!-- bytes -->
> +			<xs:element name=3D"subbuffer_count" type=3D"uint64_type" default=3D"=
4" minOccurs=3D"0"/>
> +			<xs:element name=3D"switch_timer_interval" type=3D"uint32_type" defau=
lt=3D"0" minOccurs=3D"0"/>  <!-- usec -->
> +			<xs:element name=3D"read_timer_interval" type=3D"uint32_type"/>  <!--=
 usec -->
> +			<xs:element name=3D"output_type" type=3D"event_output_type"/>
> +			<xs:element name=3D"tracefile_size" type=3D"uint64_type" default=3D"0=
" minOccurs=3D"0"/> <!-- bytes -->
> +			<xs:element name=3D"tracefile_count" type=3D"uint64_type" default=3D"=
0" minOccurs=3D"0"/>
> +			<xs:element name=3D"live_timer_interval" type=3D"uint32_type" default=
=3D"0" minOccurs=3D"0"/> <!-- usec -->
> +		</xs:all>
> +	</xs:complexType>
> +
> +	<xs:complexType name=3D"channels_type">
> +		<xs:sequence>
> +			<xs:element name=3D"channel" type=3D"channel_type" minOccurs=3D"0" ma=
xOccurs=3D"unbounded" />
> +		</xs:sequence>
> +	</xs:complexType>
> +
> +	<xs:complexType name=3D"session_type">
> +		<xs:all>
> +			<xs:element name=3D"name" type=3D"name_type" />
> +			<xs:element name=3D"path" type=3D"name_type" />
> +			<xs:element name=3D"enabled" type=3D"xs:boolean" default=3D"false" />
> +			<xs:element name=3D"snapshot_mode" type=3D"uint32_type" />
> +			<xs:element name=3D"live_timer_interval" type=3D"uint32_type" />
> +			<xs:element name=3D"channels" type=3D"channels_type" minOccurs=3D"0" =
/>
> +			<xs:element name=3D"domains" type=3D"domains_type" minOccurs=3D"0" />
> +		</xs:all>
> +	</xs:complexType>
> +
> +	<xs:complexType name=3D"event_field_type">
> +		<xs:all>
> +			<xs:element name=3D"name" type=3D"name_type" />
> +			<xs:element name=3D"type" type=3D"event_field_type_type"/>
> +			<xs:element name=3D"nowrite" type=3D"xs:int"/>
> +		</xs:all>
> +	</xs:complexType>
> +
> +
> +	<xs:complexType name=3D"domains_type">
> +		<xs:sequence>
> +			<xs:element name=3D"domain" type=3D"domain_type" minOccurs=3D"0" maxO=
ccurs=3D"unbounded" />
> +		</xs:sequence>
> +	</xs:complexType>
> +
> +	<xs:complexType name=3D"sessions_type">
> +		<xs:sequence>
> +			<xs:element name=3D"session" type=3D"session_type" minOccurs=3D"0" ma=
xOccurs=3D"unbounded" />
> +		</xs:sequence>
> +	</xs:complexType>
> +
> +	<xs:complexType name=3D"event_fields_type">
> +		<xs:sequence>
> +			<xs:element name=3D"event_field" type=3D"event_field_type" minOccurs=
=3D"0" maxOccurs=3D"unbounded" />
> +		</xs:sequence>
> +	</xs:complexType>
> +
> +	<xs:complexType name=3D"output_type">
> +		<xs:choice>
> +			<xs:element name=3D"domains" type=3D"domains_type" minOccurs=3D"0" />
> +			<xs:element name=3D"sessions" type=3D"sessions_type" minOccurs=3D"0" =
/>
> +			<xs:element name=3D"version" type=3D"version_type" minOccurs=3D"0" />
> +		</xs:choice>
> +	</xs:complexType>
> +
> +	<!-- Maps to the mi_lttng commands -->
> +	<xs:simpleType name=3D"command_string_type">
> +		<xs:restriction base=3D"xs:string">
> +			<xs:enumeration value=3D"list" />
> +			<xs:enumeration value=3D"version" />
> +		</xs:restriction>
> +	</xs:simpleType>
> +
> +	<xs:element name=3D"command">
> +		<xs:complexType>
> +			<xs:all>
> +				<xs:element name=3D"name" type=3D"command_string_type" maxOccurs=3D"=
1" />
> +				<xs:element name=3D"output" type=3D"output_type" maxOccurs=3D"1" />
> +			</xs:all>
> +		</xs:complexType>
> +	</xs:element>
> +</xs:schema>
> --=20
> 1.9.1
>=20

> From 06fd69b77160dc43c01597796048c88b9ddcd18e Mon Sep 17 00:00:00 2001
> From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
> Date: Thu, 17 Apr 2014 15:32:40 -0400
> Subject: [PATCH 5/5] Mi: add mi to snapshot command
>=20
> Signed-off-by: Jonathan Rajotte <jonathan.r.julien@gmail.com>
> ---
>  src/bin/lttng/commands/snapshot.c | 244 ++++++++++++++++++++++++++++++++=
+++--
>  src/common/mi-lttng.c             | 247 ++++++++++++++++++++++++++++++++=
+++++-
>  src/common/mi-lttng.h             | 130 ++++++++++++++++++++
>  src/common/mi_lttng.xsd           |  34 ++++++
>  4 files changed, 641 insertions(+), 14 deletions(-)
>=20
> diff --git a/src/bin/lttng/commands/snapshot.c b/src/bin/lttng/commands/s=
napshot.c
> index 21b5a05..46a863d 100644
> --- a/src/bin/lttng/commands/snapshot.c
> +++ b/src/bin/lttng/commands/snapshot.c
> @@ -27,6 +27,7 @@
>  #include <unistd.h>
> =20
>  #include <common/utils.h>
> +#include <common/mi-lttng.h>
>  #include <lttng/snapshot.h>
> =20
>  #include "../command.h"
> @@ -53,6 +54,8 @@ enum {
>  	OPT_LIST_COMMANDS,
>  };
> =20
> +static struct mi_writer *writer;
> +
>  static struct poptOption snapshot_opts[] =3D {
>  	/* longName, shortName, argInfo, argPtr, value, descrip, argDesc */
>  	{"help",      'h', POPT_ARG_NONE, 0, OPT_HELP, 0, 0},
> @@ -181,6 +184,44 @@ error_create:
>  	return NULL;
>  }
> =20
> +static int mi_list_output(void)
> +{
> +	int ret;
> +	struct lttng_snapshot_output *s_iter;
> +	struct lttng_snapshot_output_list *list;
> +
> +	ret =3D lttng_snapshot_list_output(current_session_name, &list);
> +	if (ret < 0) {
> +		goto error;
> +	}
> +
> +	ret =3D mi_lttng_snapshot_output_session_name(writer, current_session_n=
ame);
> +	if (ret) {
> +		goto error;
> +	}
> +
> +	while ((s_iter =3D lttng_snapshot_output_list_get_next(list)) !=3D NULL=
) {
> +		ret =3D mi_lttng_snapshot_list_output(writer, s_iter);
> +		if (ret) {
> +			goto error;
> +		}
> +	}
> +
> +	lttng_snapshot_output_list_destroy(list);
> +
> +	/* Close snapshot snapshots element */
> +	ret =3D mi_lttng_writer_close_element(writer);
> +	if (ret) {
> +		goto error;
> +	}
> +
> +	/* Close snapshot session element */
> +	ret =3D mi_lttng_writer_close_element(writer);
> +
> +error:
> +	return ret;
> +}
> +
>  static int list_output(void)
>  {
>  	int ret, output_seen =3D 0;
> @@ -213,6 +254,45 @@ error:
>  }
> =20
>  /*
> + * Delete output by ID (machine interface version).
> + */
> +static int mi_del_output(uint32_t id, const char *name)
> +{
> +	int ret;
> +	struct lttng_snapshot_output *output =3D NULL;
> +
> +	output =3D lttng_snapshot_output_create();
> +	if (!output) {
> +		ret =3D CMD_FATAL;
> +		goto error;
> +	}
> +
> +	if (name) {
> +		ret =3D lttng_snapshot_output_set_name(name, output);
> +	} else if (id !=3D UINT32_MAX) {
> +		ret =3D lttng_snapshot_output_set_id(id, output);
> +	} else {
> +		ret =3D CMD_ERROR;
> +		goto error;
> +	}
> +	if (ret < 0) {
> +		ret =3D CMD_FATAL;
> +		goto error;
> +	}
> +
> +	ret =3D lttng_snapshot_del_output(current_session_name, output);
> +	if (ret < 0) {
> +		goto error;
> +	}
> +
> +	ret =3D mi_lttng_snapshot_del_output(writer, id, name, current_session_=
name);
> +
> +error:
> +	lttng_snapshot_output_destroy(output);
> +	return ret;
> +}
> +
> +/*
>   * Delete output by ID.
>   */
>  static int del_output(uint32_t id, const char *name)
> @@ -258,6 +338,52 @@ error:
>  }
> =20
>  /*
> + * Add output from the user URL (machine interface).
> + */
> +static int mi_add_output(const char *url)
> +{
> +	int ret;
> +	struct lttng_snapshot_output *output =3D NULL;
> +	char name[NAME_MAX];
> +	const char *n_ptr;
> +
> +	if (!url && (!opt_data_url || !opt_ctrl_url)) {
> +		ret =3D CMD_ERROR;
> +		goto error;
> +	}
> +
> +	output =3D create_output_from_args(url);
> +	if (!output) {
> +		ret =3D CMD_FATAL;
> +		goto error;
> +	}
> +
> +	/* This call, if successful, populates the id of the output object. */
> +	ret =3D lttng_snapshot_add_output(current_session_name, output);
> +	if (ret < 0) {
> +		goto error;
> +	}
> +
> +	n_ptr =3D lttng_snapshot_output_get_name(output);
> +	if (*n_ptr =3D=3D '\0') {
> +		int pret;
> +		pret =3D snprintf(name, sizeof(name), DEFAULT_SNAPSHOT_NAME "-%" PRIu3=
2,
> +				lttng_snapshot_output_get_id(output));
> +		if (pret < 0) {
> +			PERROR("snprintf add output name");
> +		}
> +		n_ptr =3D name;
> +	}
> +
> +	ret =3D mi_lttng_snapshot_add_output(writer, current_session_name, n_pt=
r,
> +			output);
> +
> +error:
> +	lttng_snapshot_output_destroy(output);
> +	return ret;
> +}
> +
> +/*
>   * Add output from the user URL.
>   */
>  static int add_output(const char *url)
> @@ -308,7 +434,7 @@ error:
> =20
>  static int cmd_add_output(int argc, const char **argv)
>  {
> -	int ret =3D CMD_SUCCESS;
> +	int ret;
> =20
>  	if (argc < 2 && (!opt_data_url || !opt_ctrl_url)) {
>  		usage(stderr);
> @@ -316,7 +442,11 @@ static int cmd_add_output(int argc, const char **arg=
v)
>  		goto end;
>  	}
> =20
> -	ret =3D add_output(argv[1]);
> +	if (lttng_opt_mi) {
> +		ret =3D mi_add_output(argv[1]);
> +	} else {
> +		ret =3D add_output(argv[1]);
> +	}
> =20
>  end:
>  	return ret;
> @@ -324,7 +454,7 @@ end:
> =20
>  static int cmd_del_output(int argc, const char **argv)
>  {
> -	int ret =3D CMD_SUCCESS;
> +	int ret;
>  	char *name;
>  	long id;
> =20
> @@ -337,9 +467,17 @@ static int cmd_del_output(int argc, const char **arg=
v)
>  	errno =3D 0;
>  	id =3D strtol(argv[1], &name, 10);
>  	if (id =3D=3D 0 && errno =3D=3D 0) {
> -		ret =3D del_output(UINT32_MAX, name);
> +		if (lttng_opt_mi) {
> +			ret =3D mi_del_output(UINT32_MAX, name);
> +		} else {
> +			ret =3D del_output(UINT32_MAX, name);
> +		}
>  	} else if (errno =3D=3D 0 && *name =3D=3D '\0') {
> -		ret =3D del_output(id, NULL);
> +		if (lttng_opt_mi) {
> +			ret =3D mi_del_output(id, NULL);
> +		} else {
> +			ret =3D del_output(id, NULL);
> +		}
>  	} else {
>  		ERR("Argument %s not recognized", argv[1]);
>  		ret =3D -1;
> @@ -352,7 +490,42 @@ end:
> =20
>  static int cmd_list_output(int argc, const char **argv)
>  {
> -	return list_output();
> +	int ret;
> +
> +	if (lttng_opt_mi) {
> +		ret =3D mi_list_output();
> +	} else {
> +		ret =3D list_output();
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Do a snapshot record with the URL if one is given (machine interface).
> + */
> +static int mi_record(const char *url)
> +{
> +	int ret;
> +	struct lttng_snapshot_output *output =3D NULL;
> +
> +	output =3D create_output_from_args(url);
> +	if (!output) {
> +		ret =3D CMD_FATAL;
> +		goto error;
> +	}
> +
> +	ret =3D lttng_snapshot_record(current_session_name, output, 0);
> +	if (ret < 0) {
> +		goto error;
> +	}
> +
> +	ret =3D mi_lttng_snapshot_record(writer, current_session_name, url,
> +			opt_ctrl_url, opt_data_url);
> +
> +error:
> +	lttng_snapshot_output_destroy(output);
> +	return ret;
>  }
> =20
>  /*
> @@ -394,9 +567,17 @@ static int cmd_record(int argc, const char **argv)
> =20
>  	if (argc =3D=3D 2) {
>  		/* With a given URL */
> -		ret =3D record(argv[1]);
> +		if (lttng_opt_mi) {
> +			ret =3D mi_record(argv[1]);
> +		} else {
> +			ret =3D record(argv[1]);
> +		}
>  	} else {
> -		ret =3D record(NULL);
> +		if (lttng_opt_mi) {
> +			ret =3D mi_record(NULL);
> +		} else {
> +			ret =3D record(NULL);
> +		}
>  	}
> =20
>  	return ret;
> @@ -420,6 +601,23 @@ static int handle_command(const char **argv)
>  	while (cmd->func !=3D NULL) {
>  		/* Find command */
>  		if (strcmp(argv[0], cmd->name) =3D=3D 0) {
> +			if (lttng_opt_mi) {
> +				/* Type of the action */
> +				ret =3D mi_lttng_writer_write_element_string(writer,
> +						mi_lttng_element_command_action,
> +						argv[0]);
> +				if (ret) {
> +					goto end;
> +				}
> +
> +				/* Open output element */
> +				ret =3D mi_lttng_writer_open_element(writer,
> +						mi_lttng_element_command_output);
> +				if (ret) {
> +					goto end;
> +				}
> +			}
> +
>  			ret =3D cmd->func(argc, argv);
>  			goto end;
>  		}
> @@ -431,6 +629,11 @@ static int handle_command(const char **argv)
>  	ret =3D CMD_UNDEFINED;
> =20
>  end:
> +	if (lttng_opt_mi) {
> +		/* Close output element */
> +		ret =3D mi_lttng_writer_close_element(writer);
> +	}
> +
>  	return ret;
>  }
> =20
> @@ -439,18 +642,27 @@ end:
>   */
>  int cmd_snapshot(int argc, const char **argv)
>  {
> -	int opt, ret =3D CMD_SUCCESS;
> +	int opt, ret;
>  	char *session_name =3D NULL;
>  	static poptContext pc;
> =20
>  	pc =3D poptGetContext(NULL, argc, argv, snapshot_opts, 0);
>  	poptReadDefaultConfig(pc, 0);
> =20
> -	/* TODO: mi support */
> +	/* Mi check */
>  	if (lttng_opt_mi) {
> -		ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> -		ERR("mi option not supported");
> -		goto end;
> +		writer =3D mi_lttng_writer_create(fileno(stdout), lttng_opt_mi);
> +		if (!writer) {
> +			ret =3D -LTTNG_ERR_NOMEM;
> +			goto end;
> +		}
> +
> +		/* Open command element */
> +		ret =3D mi_lttng_writer_command_open(writer,
> +				mi_lttng_element_command_snapshot);
> +		if (ret) {
> +			goto end;
> +		}
>  	}
> =20
>  	while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
> @@ -514,6 +726,12 @@ int cmd_snapshot(int argc, const char **argv)
>  	}
> =20
>  end:
> +	/* Mi clean-up */
> +	if (writer && mi_lttng_writer_destroy(writer)) {
> +		/* Preserve original error code */
> +		ret =3D ret ? ret : LTTNG_ERR_MI_IO_FAIL;
> +	}
> +
>  	if (!opt_session_name) {
>  		free(session_name);
>  	}
> diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c
> index 2e4c366..ff689f5 100644
> --- a/src/common/mi-lttng.c
> +++ b/src/common/mi-lttng.c
> @@ -19,12 +19,14 @@
> =20
>  #include <include/config.h>
>  #include <common/config/config.h>
> +#include <lttng/snapshot-internal.h>
>  #include "mi-lttng.h"
> =20
>  #include <assert.h>
> =20
>  /* Strings related to command */
>  const char * const mi_lttng_element_command =3D "command";
> +const char * const mi_lttng_element_command_action =3D "action";
>  const char * const mi_lttng_element_command_version =3D "version";
>  const char * const mi_lttng_element_command_list =3D "list";
>  const char * const mi_lttng_element_command_name =3D "name";
> @@ -39,6 +41,11 @@ const char * const mi_lttng_element_version_minor =3D =
"minor";
>  const char * const mi_lttng_element_version_license =3D "license";
>  const char * const mi_lttng_element_version_patch_level =3D "patchLevel";
>  const char * const mi_lttng_element_version_description =3D "description=
";
> +const char * const mi_lttng_element_command_snapshot =3D "snapshot";
> +const char * const mi_lttng_element_command_list_snapshot =3D "list_snap=
shot";
> +const char * const mi_lttng_element_command_del_snapshot =3D "del_snapsh=
ot";
> +const char * const mi_lttng_element_command_add_snapshot =3D "add_snapsh=
ot";
> +const char * const mi_lttng_element_command_record_snapshot =3D "record_=
snapshot";
> =20
>  /* Strings related to pid */
>  const char * const mi_lttng_element_pids =3D "pids";
> @@ -56,9 +63,18 @@ const char * const mi_lttng_element_type_enum =3D "ENU=
M";
>  const char * const mi_lttng_element_type_float =3D "FLOAT";
>  const char * const mi_lttng_element_type_string =3D "STRING";
>  const char * const mi_lttng_element_nowrite =3D "nowrite";
> -
> +const char * const mi_lttng_element_id =3D "id";
>  const char * const mi_lttng_element_empty =3D "";
> =20
> +/* String related to a lttng_snapshot_output */
> +const char * const mi_lttng_element_snapshots =3D "snapshots";
> +const char * const mi_lttng_element_snapshot_session_name =3D "session_n=
ame";
> +const char * const mi_lttng_element_snapshot_n_ptr =3D "n_ptr";
> +const char * const mi_lttng_element_snapshot_data_url =3D "data_url";
> +const char * const mi_lttng_element_snapshot_ctrl_url =3D "ctrl_url";
> +const char * const mi_lttng_element_snapshot_max_size =3D "max_size";
> +
> +
>  const char *mi_lttng_loglevel_string(int value)
>  {
>  	switch (value) {
> @@ -936,3 +952,232 @@ close:
>  end:
>  	return ret;
>  }
> +
> +LTTNG_HIDDEN
> +int mi_lttng_snapshot_output_session_name(struct mi_writer *writer,
> +		const char *session_name)
> +{
> +	int ret;
> +
> +	/* Open session element */
> +	ret =3D mi_lttng_writer_open_element(writer, config_element_session);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Snapshot output list for current session name */
> +	ret =3D mi_lttng_writer_write_element_string(writer, config_element_nam=
e,
> +			session_name);
> +
> +	/* Open element snapshots (sequence one snapshot) */
> +	ret =3D mi_lttng_writer_open_element(writer, mi_lttng_element_snapshots=
);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +end:
> +	return ret;
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_snapshot_list_output(struct mi_writer *writer,
> +		struct lttng_snapshot_output *output)
> +{
> +	int ret;
> +
> +	/* Open element snapshot output */
> +	ret =3D mi_lttng_writer_open_element(writer, mi_lttng_element_command_s=
napshot);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* ID of the snapshot output */
> +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +			mi_lttng_element_id, output->id);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Name of the output */
> +	ret =3D mi_lttng_writer_write_element_string(writer, config_element_nam=
e,
> +			output->name);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Destination of the output (ctrl_url)*/
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +			mi_lttng_element_snapshot_ctrl_url, output->ctrl_url);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Destination of the output (data_url) */
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +			mi_lttng_element_snapshot_data_url, output->data_url);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* total size of all stream combined */
> +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +			mi_lttng_element_snapshot_max_size, output->max_size);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Close snapshot output element */
> +	ret =3D mi_lttng_writer_close_element(writer);
> +
> +end:
> +	return ret;
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_snapshot_del_output(struct mi_writer *writer, int id,
> +		const char *name, const char *current_session_name)
> +{
> +	int ret;
> +
> +	/* Open element del_snapshot */
> +	ret =3D mi_lttng_writer_open_element(writer,
> +			mi_lttng_element_command_snapshot);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +
> +	if (id !=3D UINT32_MAX) {
> +		/* "Snapshot output "id" successfully deleted for "current_session_nam=
e" */
> +		/* ID of the snapshot output */
> +		ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +				mi_lttng_element_id, id);
> +		if (ret) {
> +			goto end;
> +		}
> +	} else {
> +		/* "Snapshot output "name" successfully deleted for session "current_s=
ession_name" */
> +		/* Name of the output */
> +		ret =3D mi_lttng_writer_write_element_string(writer, config_element_na=
me,
> +				name);
> +		if (ret) {
> +			goto end;
> +		}
> +	}
> +
> +	/* Snapshot was deleted for session "current_session_name"*/
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +			mi_lttng_element_snapshot_session_name,
> +			current_session_name);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Close snapshot element */
> +	ret =3D mi_lttng_writer_close_element(writer);
> +
> +end:
> +	return ret;
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_snapshot_add_output(struct mi_writer *writer,
> +		const char *current_session_name, const char *n_ptr,
> +		struct lttng_snapshot_output *output)
> +{
> +	int ret;
> +
> +	/* Open element snapshot */
> +	ret =3D mi_lttng_writer_open_element(writer,
> +			mi_lttng_element_command_snapshot);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Snapshot output id */
> +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer, mi_lttng_ele=
ment_id,
> +			output->id);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Snapshot output names */
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +			config_element_name, n_ptr);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Destination of the output (ctrl_url)*/
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +			mi_lttng_element_snapshot_ctrl_url, output->ctrl_url);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Snapshot added for session "current_session_name"*/
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +			mi_lttng_element_snapshot_session_name, current_session_name);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* total size of all stream combined */
> +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +			mi_lttng_element_snapshot_max_size, output->max_size);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Close snapshot element */
> +	ret =3D mi_lttng_writer_close_element(writer);
> +
> +end:
> +	return ret;
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_snapshot_record(struct mi_writer *writer,
> +		const char *current_session_name, const char *url,
> +		const char *cmdline_ctrl_url, const char *cmdline_data_url)
> +{
> +	int ret;
> +
> +	/* Open element snapshot */
> +	ret =3D mi_lttng_writer_open_element(writer,
> +			mi_lttng_element_command_snapshot);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* If a valid an url was given, serialize it,
> +	 * else take the command line data and ctrl urls*/
> +	if (url) {
> +		/* Destination of the output (ctrl_url)*/
> +		ret =3D mi_lttng_writer_write_element_string(writer,
> +				mi_lttng_element_snapshot_ctrl_url, url);
> +		if (ret) {
> +			goto end;
> +		}
> +	} else if (cmdline_ctrl_url) {
> +		/* Destination of the output (ctrl_url)*/
> +		ret =3D mi_lttng_writer_write_element_string(writer,
> +				mi_lttng_element_snapshot_ctrl_url, cmdline_ctrl_url);
> +		if (ret) {
> +			goto end;
> +		}
> +
> +		/* Destination of the output (data_url) */
> +		ret =3D mi_lttng_writer_write_element_string(writer,
> +				mi_lttng_element_snapshot_data_url, cmdline_data_url);
> +		if (ret) {
> +			goto end;
> +		}
> +	}
> +
> +	/* Close record_snapshot element */
> +	ret =3D mi_lttng_writer_close_element(writer);
> +
> +end:
> +	return ret;
> +}
> diff --git a/src/common/mi-lttng.h b/src/common/mi-lttng.h
> index 2dca80c..faa6d38 100644
> --- a/src/common/mi-lttng.h
> +++ b/src/common/mi-lttng.h
> @@ -26,6 +26,11 @@
>  #include <common/config/config.h>
>  #include <lttng/lttng.h>
> =20
> +#include <stdint.h>
> +
> +/* Don't want to reference snapshot-internal.h here */
> +struct lttng_snapshot_output;
> +
>  /* Instance of a machine interface writer. */
>  struct mi_writer {
>  	struct config_writer *writer;
> @@ -46,10 +51,16 @@ struct mi_lttng_version {
> =20
>  /* Strings related to command */
>  const char * const mi_lttng_element_command;
> +const char * const mi_lttng_element_command_action;
>  const char * const mi_lttng_element_command_version;
>  const char * const mi_lttng_element_command_list;
>  const char * const mi_lttng_element_command_name;
>  const char * const mi_lttng_element_command_output;
> +const char * const mi_lttng_element_command_snapshot;
> +const char * const mi_lttng_element_command_list_snapshot;
> +const char * const mi_lttng_element_command_del_snapshot;
> +const char * const mi_lttng_element_command_add_snapshot;
> +const char * const mi_lttng_element_command_record_snapshot;
> =20
>  /* Strings related to command: version */
>  const char * const mi_lttng_element_version;
> @@ -78,6 +89,14 @@ const char * const mi_lttng_element_type_float;
>  const char * const mi_lttng_element_type_string;
>  const char * const mi_lttng_element_nowrite;
> =20
> +/* String related to a lttng_snashot */
> +const char * const mi_lttng_element_snapshots;
> +const char * const mi_lttng_element_snapshot_session_name;
> +const char * const mi_lttng_element_snapshot_n_ptr;
> +const char * const mi_lttng_element_snapshot_data_url;
> +const char * const mi_lttng_element_snapshot_ctrl_url;
> +const char * const mi_lttng_element_snapshot_max_size;
> +
>  /* Utility string function  */
>  const char *mi_lttng_loglevel_string(int value);
>  const char *mi_lttng_logleveltype_string(enum lttng_loglevel_type value);
> @@ -507,4 +526,115 @@ int mi_lttng_pids_open(struct mi_writer *writer);
>  int mi_lttng_pid(struct mi_writer *writer, pid_t pid , const char *cmdli=
ne,
>  		int is_open);
> =20
> +/*
> + * Machine interface of the snapshot list_output. It specify the session=
 for which
> + * we are listing snapshots, and it open a snapshots element to list a s=
equence
> + * of snapshot.
> + *
> + * writer An instance of a machine interface writer.
> + *
> + * session_name: Snapshot output for session "session_name".
> + *
> + * Note: The client has to close the session and the snapshots elements =
after
> + * having list every lttng_snapshot_output.
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_snapshot_output_session_name(struct mi_writer *writer,
> +		const char *session_name);
> +
> +/*
> + * Machine interface of the snapshot output.
> + * The machine interface serialize the following attribute:
> + * 	- id: ID of the snapshot output.
> + * 	- name: Name of the output.
> + * 	- data_url : Destination of the output.
> + * 	- ctrl_url: Destination of the output.
> + * 	- max_size: total size of all stream combined.
> + *
> + * writer An instance of a machine interface writer.
> + *
> + * output: iterator over a lttng_snapshot_output_list.
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_snapshot_list_output(struct mi_writer *writer,
> +		struct lttng_snapshot_output *output);
> +
> +/*
> + * Machine interface of the output of the command snapshot del output
> + * when deleting a snapshot either by id or by name.
> + * If the snapshot was founded and successfully deleted using its id,
> + * we return the id of the snapshot and the current session name on whic=
h it
> + * was attached.
> + *
> + * Otherwise, We  do the same process with the name of the snapshot, if =
the
> + * snapshot output id is undefined.
> + *
> + * writer An instance of a machine interface writer.
> + *
> + * id: ID of the snapshot output.
> + *
> + * name: Name of the snapshot.
> + *
> + * current_session_name: Session which the snapshot belong to.
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_snapshot_del_output(struct mi_writer *writer, int id,
> +		const char *name, const char *current_session_name);
> +
> +/*
> + * Machine interface of the output of the command snapshot add output
> + * when adding a snapshot from a user URL.
> + *
> + * If the snapshot was successfully added, the machine interface list
> + * these informations:
> + * - id: ID of the newly add snapshot output.
> + * - current_session_name: Name of the session to which the output was a=
dded.
> + * - ctrl_url: Destination of the output.
> + * - max_size: total size of all stream combined.
> + *
> + * writer An instance of a machine interface writer.
> + *
> + * current_session_name: Session which the snapshot belong to.
> + *
> + * n_ptr:
> + *
> + * output: iterator over a lttng_snapshot_output_list which contain the =
snapshot
> + * output informations.
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_snapshot_add_output(struct mi_writer *writer,
> +		const char *current_session_name, const char *n_ptr,
> +		struct lttng_snapshot_output *output);
> +
> +/*
> + * Machine interface of the output of the command snapshot record  from =
a URL (if given).
> + *
> + * If the snapshot is successfully record from a url, the machine interf=
ace
> + * output the following informations:
> + * - url: Destination of the output store in the snapshot.
> + *
> + * Otherwise, the machine interface output the data and ctrl url receive
> + * from the command-line.
> + *
> + * writer An instance of a machine interface writer.
> + *
> + * current_session_name: Snapshot record for session "current_session_na=
me".
> + *
> + * ctrl_url, data_url: Destination of the output receive from the comman=
d-line.
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_snapshot_record(struct mi_writer *writer,
> +		const char *current_session_name, const char *url,
> +		const char *cmdline_ctrl_url, const char *cmdline_data_url);
> +
>  #endif /* _MI_LTTNG_H */
> diff --git a/src/common/mi_lttng.xsd b/src/common/mi_lttng.xsd
> index 6fc25c6..e47f4d4 100644
> --- a/src/common/mi_lttng.xsd
> +++ b/src/common/mi_lttng.xsd
> @@ -248,6 +248,24 @@ THE SOFTWARE.
>  		</xs:all>
>  	</xs:complexType>
> =20
> +	<!-- Maps to struct lttng_snapshot_output -->
> +	<xs:complexType name=3D"snapshot_type">
> +		<xs:all>
> +			<xs:element name=3D"id" type=3D"uint32_type" minOccurs=3D"0" />
> +			<xs:element name=3D"max_size" type=3D"uint64_type" minOccurs=3D"0" />
> +			<xs:element name=3D"name" type=3D"name_type" minOccurs=3D"0" />
> +			<xs:element name=3D"session_name" type=3D"name_type" minOccurs=3D"0" =
/>
> +			<xs:element name=3D"ctrl_url" type=3D"name_type" minOccurs=3D"0"/>
> +			<xs:element name=3D"data_url" type=3D"name_type" minOccurs=3D"0"/>
> +		</xs:all>
> +	</xs:complexType>
> +
> +	<xs:complexType name=3D"snapshots_type">
> +		<xs:sequence>
> +			<xs:element name=3D"snapshot" type=3D"snapshot_type" minOccurs=3D"0" =
maxOccurs=3D"unbounded" />
> +		</xs:sequence>
> +	</xs:complexType>
> +
>  	<xs:complexType name=3D"channels_type">
>  		<xs:sequence>
>  			<xs:element name=3D"channel" type=3D"channel_type" minOccurs=3D"0" ma=
xOccurs=3D"unbounded" />
> @@ -263,6 +281,7 @@ THE SOFTWARE.
>  			<xs:element name=3D"live_timer_interval" type=3D"uint32_type" />
>  			<xs:element name=3D"channels" type=3D"channels_type" minOccurs=3D"0" =
/>
>  			<xs:element name=3D"domains" type=3D"domains_type" minOccurs=3D"0" />
> +			<xs:element name=3D"snapshots" type=3D"snapshots_type" minOccurs=3D"0=
" />
>  		</xs:all>
>  	</xs:complexType>
> =20
> @@ -293,10 +312,23 @@ THE SOFTWARE.
>  		</xs:sequence>
>  	</xs:complexType>
> =20
> +
> +	<!-- Type of snapshot commands -->
> +	<xs:simpleType name=3D"snapshot_action_type">
> +		<xs:restriction base=3D"xs:string">
> +			<xs:enumeration value=3D"list-output"/>
> +			<xs:enumeration value=3D"del-output"/>
> +			<xs:enumeration value=3D"add-output"/>
> +			<xs:enumeration value=3D"record-output"/>
> +		</xs:restriction>
> +	</xs:simpleType>
> +
>  	<xs:complexType name=3D"output_type">
>  		<xs:choice>
>  			<xs:element name=3D"domains" type=3D"domains_type" minOccurs=3D"0" />
> +			<xs:element name=3D"session" type=3D"session_type" minOccurs=3D"0" />
>  			<xs:element name=3D"sessions" type=3D"sessions_type" minOccurs=3D"0" =
/>
> +			<xs:element name=3D"snapshot" type=3D"snapshot_type" minOccurs=3D"0" =
/>
>  			<xs:element name=3D"version" type=3D"version_type" minOccurs=3D"0" />
>  		</xs:choice>
>  	</xs:complexType>
> @@ -305,6 +337,7 @@ THE SOFTWARE.
>  	<xs:simpleType name=3D"command_string_type">
>  		<xs:restriction base=3D"xs:string">
>  			<xs:enumeration value=3D"list" />
> +			<xs:enumeration value=3D"snapshot" />
>  			<xs:enumeration value=3D"version" />
>  		</xs:restriction>
>  	</xs:simpleType>
> @@ -313,6 +346,7 @@ THE SOFTWARE.
>  		<xs:complexType>
>  			<xs:all>
>  				<xs:element name=3D"name" type=3D"command_string_type" maxOccurs=3D"=
1" />
> +				<xs:element name=3D"action" type=3D"snapshot_action_type" minOccurs=
=3D"0" />
>  				<xs:element name=3D"output" type=3D"output_type" maxOccurs=3D"1" />
>  			</xs:all>
>  		</xs:complexType>
> --=20
> 1.9.1
>=20


--eVzOFob/8UvintSX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTcldJXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02rZsH/ix9YLAGWDNBWyuHW8dXWg3B
tGD/rxA2NR9EPG9DTJu66xXMwSO+oVhJsnIeIA/x7jiLZYrdLYR7I9/54wd/UWWD
3tT5L+BXAlDUzD1pCNLQ26SWXcRv7uWAJ3O0S0dwfRGd1kt2REIUBjS+VCEfAAEn
sWUAeeXzDH9aJzPwnTemOqfzbBgQtggG/JinfyubJYeIqzH9QgpGn02kIS933T+3
YADj9q0/NkgGaTru9xU2qWNO6SNPxOBdKgDcO4T7FIugNdZI19ldI/cLgiWYdD6E
ZxgqUOaR+Fujr0cE8mrKrELjG4TwHNPKkS/B+Pq0TbIQj0hdMoEISrs5Lw0Z8WQ=
=6OQ/
-----END PGP SIGNATURE-----

--eVzOFob/8UvintSX--


--===============1831437338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1831437338==--
