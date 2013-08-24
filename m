From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: check UST float
	field	mantissa length
Date: Sat, 24 Aug 2013 14:55:50 -0400
Message-ID: <20130824185550.GD13216__12825.4290124916$1377370610$gmane$org@Krystal>
References: <20130822200558.GA2383@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VDJ04-0007Zi-6s
	for lttng-dev@lists.lttng.org; Sat, 24 Aug 2013 14:55:54 -0400
Content-Disposition: inline
In-Reply-To: <20130822200558.GA2383@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> Fixes #473

I notice that this patch is merged,

Thanks,

Mathieu

> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
> index 5c4dc5a..cf4b7ca 100644
> --- a/src/bin/lttng-sessiond/ust-app.c
> +++ b/src/bin/lttng-sessiond/ust-app.c
> @@ -4664,7 +4664,8 @@ static int add_event_ust_registry(int sock, int sobjd, int cobjd, char *name,
>  	 */
>  	ret_code = ust_registry_create_event(registry, chan_reg_key,
>  			sobjd, cobjd, name, sig, nr_fields, fields, loglevel,
> -			model_emf_uri, ua_sess->buffer_type, &event_id);
> +			model_emf_uri, ua_sess->buffer_type, &event_id,
> +			app);
>  
>  	/*
>  	 * The return value is returned to ustctl so in case of an error, the
> diff --git a/src/bin/lttng-sessiond/ust-registry.c b/src/bin/lttng-sessiond/ust-registry.c
> index e22fc6f..65ba82c 100644
> --- a/src/bin/lttng-sessiond/ust-registry.c
> +++ b/src/bin/lttng-sessiond/ust-registry.c
> @@ -23,6 +23,7 @@
>  #include <lttng/lttng.h>
>  
>  #include "ust-registry.h"
> +#include "ust-app.h"
>  #include "utils.h"
>  
>  /*
> @@ -72,15 +73,77 @@ static unsigned long ht_hash_event(void *_key, unsigned long seed)
>  }
>  
>  /*
> + * Return negative value on error, 0 if OK.
> + *
> + * TODO: we could add stricter verification of more types to catch
> + * errors in liblttng-ust implementation earlier than consumption by the
> + * trace reader.
> + */
> +static
> +int validate_event_field(struct ustctl_field *field,
> +		const char *event_name,
> +		struct ust_app *app)
> +{
> +	switch(field->type.atype) {
> +	case ustctl_atype_integer:
> +	case ustctl_atype_enum:
> +	case ustctl_atype_array:
> +	case ustctl_atype_sequence:
> +	case ustctl_atype_string:
> +		break;
> +
> +	case ustctl_atype_float:
> +		switch (field->type.u.basic._float.mant_dig) {
> +		case 0:
> +			WARN("UST application '%s' (pid: %d) has unknown float mantissa '%u' "
> +				"in field '%s', rejecting event '%s'",
> +				app->name, app->pid,
> +				field->type.u.basic._float.mant_dig,
> +				field->name,
> +				event_name);
> +			return -EINVAL;
> +		default:
> +			break;
> +		}
> +		break;
> +
> +	default:
> +		return -ENOENT;
> +	}
> +	return 0;
> +}
> +
> +static
> +int validate_event_fields(size_t nr_fields, struct ustctl_field *fields,
> +		const char *event_name, struct ust_app *app)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < nr_fields; i++) {
> +		if (validate_event_field(&fields[i], event_name, app) < 0)
> +			return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +/*
>   * Allocate event and initialize it. This does NOT set a valid event id from a
>   * registry.
>   */
>  static struct ust_registry_event *alloc_event(int session_objd,
>  		int channel_objd, char *name, char *sig, size_t nr_fields,
> -		struct ustctl_field *fields, int loglevel, char *model_emf_uri)
> +		struct ustctl_field *fields, int loglevel, char *model_emf_uri,
> +		struct ust_app *app)
>  {
>  	struct ust_registry_event *event = NULL;
>  
> +	/*
> +	 * Ensure that the field content is valid.
> +	 */
> +	if (validate_event_fields(nr_fields, fields, name, app) < 0) {
> +		return NULL;
> +	}
> +
>  	event = zmalloc(sizeof(*event));
>  	if (!event) {
>  		PERROR("zmalloc ust registry event");
> @@ -185,7 +248,8 @@ end:
>  int ust_registry_create_event(struct ust_registry_session *session,
>  		uint64_t chan_key, int session_objd, int channel_objd, char *name,
>  		char *sig, size_t nr_fields, struct ustctl_field *fields, int loglevel,
> -		char *model_emf_uri, int buffer_type, uint32_t *event_id_p)
> +		char *model_emf_uri, int buffer_type, uint32_t *event_id_p,
> +		struct ust_app *app)
>  {
>  	int ret;
>  	uint32_t event_id;
> @@ -222,7 +286,7 @@ int ust_registry_create_event(struct ust_registry_session *session,
>  	}
>  
>  	event = alloc_event(session_objd, channel_objd, name, sig, nr_fields,
> -			fields, loglevel, model_emf_uri);
> +			fields, loglevel, model_emf_uri, app);
>  	if (!event) {
>  		ret = -ENOMEM;
>  		goto error_free;
> diff --git a/src/bin/lttng-sessiond/ust-registry.h b/src/bin/lttng-sessiond/ust-registry.h
> index a82aeb2..f195b74 100644
> --- a/src/bin/lttng-sessiond/ust-registry.h
> +++ b/src/bin/lttng-sessiond/ust-registry.h
> @@ -225,7 +225,8 @@ void ust_registry_session_destroy(struct ust_registry_session *session);
>  int ust_registry_create_event(struct ust_registry_session *session,
>  		uint64_t chan_key, int session_objd, int channel_objd, char *name,
>  		char *sig, size_t nr_fields, struct ustctl_field *fields, int loglevel,
> -		char *model_emf_uri, int buffer_type, uint32_t *event_id_p);
> +		char *model_emf_uri, int buffer_type, uint32_t *event_id_p,
> +		struct ust_app *app);
>  struct ust_registry_event *ust_registry_find_event(
>  		struct ust_registry_channel *chan, char *name, char *sig);
>  void ust_registry_destroy_event(struct ust_registry_channel *chan,
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
