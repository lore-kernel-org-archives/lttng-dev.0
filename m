From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace 2/2] Fix: Unified types
	expected	by the Definition Python interface.
Date: Fri, 25 Jan 2013 11:39:22 -0500
Message-ID: <20130125163922.GA32661__11775.3383740366$1359132009$gmane$org@Krystal>
References: <1358898446-1622-1-git-send-email-jeremie.galarneau@efficios.com>
	<1358898446-1622-2-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TymJI-0001DO-67
	for lttng-dev@lists.lttng.org; Fri, 25 Jan 2013 11:39:24 -0500
Content-Disposition: inline
In-Reply-To: <1358898446-1622-2-git-send-email-jeremie.galarneau@efficios.com>
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

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> This change makes the Python iterator test case execute successfully.

merged, thanks!

Mathieu

> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  bindings/python/babeltrace.i.in | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> =

> diff --git a/bindings/python/babeltrace.i.in b/bindings/python/babeltrace=
.i.in
> index dd49ba5..a5426c8 100644
> --- a/bindings/python/babeltrace.i.in
> +++ b/bindings/python/babeltrace.i.in
> @@ -553,8 +553,8 @@ struct bt_ctf_event *bt_ctf_iter_read_event(struct bt=
_ctf_iter *iter);
>  		const struct definition *scope,	const char *field);
>  %rename("_bt_ctf_get_index") bt_ctf_get_index(const struct bt_ctf_event =
*ctf_event,
>  		const struct definition *field,	unsigned int index);
> -%rename("_bt_ctf_field_name") bt_ctf_field_name(const struct definition =
*def);
> -%rename("_bt_ctf_field_type") bt_ctf_field_type(const struct declaration=
 *def);
> +%rename("_bt_ctf_field_name") bt_ctf_field_name(const struct definition =
*field);
> +%rename("_bt_ctf_field_type") bt_ctf_field_type(const struct declaration=
 *field);
>  %rename("_bt_ctf_get_int_signedness") bt_ctf_get_int_signedness(
>  		const struct declaration *field);
>  %rename("_bt_ctf_get_int_base") bt_ctf_get_int_base(const struct declara=
tion *field);
> @@ -572,6 +572,8 @@ struct bt_ctf_event *bt_ctf_iter_read_event(struct bt=
_ctf_iter *iter);
>  		bt_ctf_event_decl *event);
>  %rename("_bt_ctf_get_decl_field_name") bt_ctf_get_decl_field_name(
>  		const struct bt_ctf_field_decl *field);
> +%rename("_bt_ctf_get_decl_from_def") bt_ctf_get_decl_from_def(
> +		const struct definition *field);
>  =

>  const struct definition *bt_ctf_get_top_level_scope(const struct bt_ctf_=
event *ctf_event,
>  		enum bt_ctf_scope scope);
> @@ -584,8 +586,8 @@ const struct definition *bt_ctf_get_field(const struc=
t bt_ctf_event *ctf_event,
>  const struct definition *bt_ctf_get_index(const struct bt_ctf_event *ctf=
_event,
>  		const struct definition *field,
>  		unsigned int index);
> -const char *bt_ctf_field_name(const struct definition *def);
> -enum ctf_type_id bt_ctf_field_type(const struct declaration *def);
> +const char *bt_ctf_field_name(const struct definition *field);
> +enum ctf_type_id bt_ctf_field_type(const struct declaration *field);
>  int bt_ctf_get_int_signedness(const struct declaration *field);
>  int bt_ctf_get_int_base(const struct declaration *field);
>  int bt_ctf_get_int_byte_order(const struct declaration *field);
> @@ -599,6 +601,7 @@ char *bt_ctf_get_string(const struct definition *fiel=
d);
>  int bt_ctf_field_get_error(void);
>  const char *bt_ctf_get_decl_event_name(const struct bt_ctf_event_decl *e=
vent);
>  const char *bt_ctf_get_decl_field_name(const struct bt_ctf_field_decl *f=
ield);
> +const struct declaration *bt_ctf_get_decl_from_def(const struct definiti=
on *field);
>  =

>  %pythoncode%{
>  =

> @@ -839,25 +842,25 @@ class ctf:
>  =

>  		def field_type(self):
>  			"""Return the type of a field or -1 if unknown."""
> -			return _bt_ctf_field_type(self._d)
> +			return _bt_ctf_field_type(_bt_ctf_get_decl_from_def(self._d))
>  =

>  		def get_int_signedness(self):
>  			"""
>  			Return the signedness of an integer:
>  			0 if unsigned; 1 if signed; -1 on error.
>  			"""
> -			return _bt_ctf_get_int_signedness(self._d)
> +			return _bt_ctf_get_int_signedness(_bt_ctf_get_decl_from_def(self._d))
>  =

>  		def get_int_base(self):
>  			"""Return the base of an int or a negative value on error."""
> -			return _bt_ctf_get_int_base(self._d)
> +			return _bt_ctf_get_int_base(_bt_ctf_get_decl_from_def(self._d))
>  =

>  		def get_int_byte_order(self):
>  			"""
>  			Return the byte order of an int or a negative
>  			value on error.
>  			"""
> -			return _bt_ctf_get_int_byte_order(self._d)
> +			return _bt_ctf_get_int_byte_order(_bt_ctf_get_decl_from_def(self._d))
>  =

>  		def get_int_len(self):
>  			"""
> @@ -871,14 +874,14 @@ class ctf:
>  			Return the encoding of an int or a string.
>  			Return a negative value on error.
>  			"""
> -			return _bt_ctf_get_encoding(self._d)
> +			return _bt_ctf_get_encoding(_bt_ctf_get_decl_from_def(self._d))
>  =

>  		def get_array_len(self):
>  			"""
>  			Return the len of an array or a negative
>  			value on error.
>  			"""
> -			return _bt_ctf_get_array_len(self._d)
> +			return _bt_ctf_get_array_len(_bt_ctf_get_decl_from_def(self._d))
>  =

>  		def get_uint64(self):
>  			"""
> -- =

> 1.8.1.1
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
