From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Use a unique name to get a
	field's value
Date: Wed, 24 Jul 2013 15:32:49 -0400
Message-ID: <CA+jJMxs3pUtyq37KwdpJBJJ6GxpOtsJAdQu_WGh2CS8mZp_zQA__37783.3307524726$1374694634$gmane$org@mail.gmail.com>
References: <1374659868-6264-1-git-send-email-xiaonahappy13@163.com>
	<1374659868-6264-2-git-send-email-xiaonahappy13@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1V24nu-0001B8-SE
	for lttng-dev@lists.lttng.org; Wed, 24 Jul 2013 15:33:00 -0400
Received: by mail-wg0-f47.google.com with SMTP id j13so797083wgh.2
	for <lttng-dev@lists.lttng.org>; Wed, 24 Jul 2013 12:32:49 -0700 (PDT)
In-Reply-To: <1374659868-6264-2-git-send-email-xiaonahappy13@163.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Xiaona Han <xiaonahappy13@163.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Wed, Jul 24, 2013 at 5:57 AM, Xiaona Han <xiaonahappy13@163.com> wrote:
> Signed-off-by: Xiaona Han <xiaonahappy13@163.com>
> ---
>  bindings/python/babeltrace.i.in |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
>
> diff --git a/bindings/python/babeltrace.i.in b/bindings/python/babeltrace=
.i.in
> index 880b23e..806cc73 100755
> --- a/bindings/python/babeltrace.i.in
> +++ b/bindings/python/babeltrace.i.in
> @@ -986,6 +986,25 @@ class ctf:
>                         """
>                         return _bt_ctf_get_string(self._d)
>
> +               def get_value(self):
> +                       """
> +                       Return the value associated with the field accord=
ing to its type.
> +                       If the field does not exist, the value returned i=
s undefined.
> +                       To check if an error occured, use the ctf.field_e=
rror() function
> +                       after accessing a field.
> +                       """
> +                       id =3D self.field_type()
> +                       if id =3D=3D ctf.type_id.STRING:
> +                               return self.get_str()
> +                       if type_id =3D=3D ctf.type_id.ARRAY:
> +                               return self.get_char_array()
> +                       if type_id =3D=3D ctf.type_id.INTEGER:
> +                               if self.get_int_signedness =3D=3D 0:
> +                                       return self.get_uint64()
> +                               else:
> +                                       return self.get_int64()
> +                       return None
> +

You are assigning the field's type to "id" and then using "type_id".
Did you test this?

Also, while I can understand not supporting compound types right-away,
please make sure it supports floating point and enums.

Regards,
J=E9r=E9mie

>                 def get_scope(self):
>                         """Return the scope of a field or None on error."=
""
>                         return self._s
> --
> 1.7.1
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
