From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools v2] mi: support "add-context
	--list"
Date: Sun, 27 May 2018 08:53:27 -0400
Message-ID: <CA+jJMxsf8gXGAf863gzKB4xBfiE1jZcCbQqosOEBJF-fL=R_yw__48067.6404470161$1527425520$gmane$org@mail.gmail.com>
References: <1519851961-22815-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3476875940807653542=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 40v0Kw48y9z18ml
 for <lttng-dev@lists.lttng.org>; Sun, 27 May 2018 08:53:56 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id B992C1B7EE3
 for <lttng-dev@lists.lttng.org>; Sun, 27 May 2018 08:53:50 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id fi8PODzl8FG8 for <lttng-dev@lists.lttng.org>;
 Sun, 27 May 2018 08:53:49 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 67D5A1B7ED2
 for <lttng-dev@lists.lttng.org>; Sun, 27 May 2018 08:53:49 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id fRaHyPVtbbRZ for <lttng-dev@lists.lttng.org>;
 Sun, 27 May 2018 08:53:49 -0400 (EDT)
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 by mail.efficios.com (Postfix) with ESMTPSA id ED3501B7EBE
 for <lttng-dev@lists.lttng.org>; Sun, 27 May 2018 08:53:48 -0400 (EDT)
Received: by mail-wm0-f51.google.com with SMTP id j4-v6so25386182wme.1
 for <lttng-dev@lists.lttng.org>; Sun, 27 May 2018 05:53:48 -0700 (PDT)
In-Reply-To: <1519851961-22815-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============3476875940807653542==
Content-Type: multipart/alternative; boundary="000000000000f641f7056d2f7d22"

--000000000000f641f7056d2f7d22
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged in master with some small changes.

Thanks!
J=C3=A9r=C3=A9mie

On 28 February 2018 at 16:06, Jonathan Rajotte <
jonathan.rajotte-julien@efficios.com> wrote:

> The symbol element is the string passed/to be passed on the cli
> for the --type option.
>
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
> v2:
>     Mi -> MI (2x)
>     Missing empty line after variable declaration at top of function (2x)
>     mi_open() -> mi_open(void)
>     Check error on fileno()
>     mi_close argument is now an enum cmd_err_code
>
> ---
>  src/bin/lttng/commands/add_context.c | 294 ++++++++++++++++++++++++-----=
-
> -----
>  src/common/mi-lttng-3.0.xsd          |  13 +-
>  src/common/mi-lttng.c                |   3 +
>  src/common/mi-lttng.h                |   3 +
>  tests/regression/tools/mi/test_mi    |  15 +-
>  tests/utils/utils.sh                 |   7 +
>  6 files changed, 236 insertions(+), 99 deletions(-)
>
> diff --git a/src/bin/lttng/commands/add_context.c
> b/src/bin/lttng/commands/add_context.c
> index 209a9f4..95c834c 100644
> --- a/src/bin/lttng/commands/add_context.c
> +++ b/src/bin/lttng/commands/add_context.c
> @@ -482,20 +482,7 @@ struct ctx_type_list {
>         .head =3D CDS_LIST_HEAD_INIT(ctx_type_list.head),
>  };
>
> -/*
> - * Pretty print context type.
> - */
> -static void print_ctx_type(FILE *ofp)
> -{
> -       int i =3D 0;
>
> -       while (ctx_opts[i].symbol !=3D NULL) {
> -               if (!ctx_opts[i].hide_help) {
> -                       fprintf(ofp, "%s\n", ctx_opts[i].symbol);
> -               }
> -               i++;
> -       }
> -}
>
>  /*
>   * Find context numerical value from string.
> @@ -535,6 +522,190 @@ enum lttng_domain_type get_domain(void)
>         }
>  }
>
> +static int mi_open(void)
> +{
> +       int ret;
> +
> +       /* MI check */
> +       if (!lttng_opt_mi) {
> +               ret =3D 0;
> +               goto end;
> +       }
> +
> +       ret =3D fileno(stdout);
> +       if (ret < 0) {
> +               PERROR("fileno on stdout");
> +               ret =3D CMD_ERROR;
> +               goto end;
> +       }
> +
> +       writer =3D mi_lttng_writer_create(ret, lttng_opt_mi);
> +       if (!writer) {
> +               ret =3D -LTTNG_ERR_NOMEM;
> +               goto end;
> +       }
> +
> +       /* Open command element */
> +       ret =3D mi_lttng_writer_command_open(writer,
> +                       mi_lttng_element_command_add_context);
> +       if (ret) {
> +               ret =3D CMD_ERROR;
> +               goto end;
> +       }
> +
> +       /* Open output element */
> +       ret =3D mi_lttng_writer_open_element(writer,
> +                       mi_lttng_element_command_output);
> +       if (ret) {
> +               ret =3D CMD_ERROR;
> +               goto end;
> +       }
> +end:
> +       return ret;
> +}
> +
> +static int mi_close(enum cmd_error_code success)
> +{
> +       int ret;
> +
> +       /* MI closing */
> +       if (!lttng_opt_mi) {
> +               ret =3D 0;
> +               goto end;
> +       }
> +       /* Close  output element */
> +       ret =3D mi_lttng_writer_close_element(writer);
> +       if (ret) {
> +               ret =3D CMD_ERROR;
> +               goto end;
> +       }
> +
> +       /* Success ? */
> +       ret =3D mi_lttng_writer_write_element_bool(writer,
> +                       mi_lttng_element_command_success, !success);
> +       if (ret) {
> +               ret =3D CMD_ERROR;
> +               goto end;
> +       }
> +
> +       /* Command element close */
> +       ret =3D mi_lttng_writer_command_close(writer);
> +       if (ret) {
> +               ret =3D CMD_ERROR;
> +               goto end;
> +       }
> +end:
> +       return ret;
> +}
> +
> +static void populate_context(struct lttng_event_context *context, const
> struct ctx_opts *opt)
> +{
> +       char *ptr;
> +
> +       context->ctx =3D (enum lttng_event_context_type) opt->ctx_type;
> +       switch (context->ctx) {
> +       case LTTNG_EVENT_CONTEXT_PERF_COUNTER:
> +       case LTTNG_EVENT_CONTEXT_PERF_CPU_COUNTER:
> +       case LTTNG_EVENT_CONTEXT_PERF_THREAD_COUNTER:
> +               context->u.perf_counter.type =3D opt->u.perf.type;
> +               context->u.perf_counter.config =3D opt->u.perf.config;
> +               strncpy(context->u.perf_counter.name, opt->symbol,
> +                               LTTNG_SYMBOL_NAME_LEN);
> +               context->u.perf_counter.name[LTTNG_SYMBOL_NAME_LEN - 1] =
=3D
> '\0';
> +               /* Replace : and - by _ */
> +               while ((ptr =3D strchr(context->u.perf_counter.name, '-')=
)
> !=3D NULL) {
> +                       *ptr =3D '_';
> +               }
> +               while ((ptr =3D strchr(context->u.perf_counter.name, ':')=
)
> !=3D NULL) {
> +                       *ptr =3D '_';
> +               }
> +               break;
> +       case LTTNG_EVENT_CONTEXT_APP_CONTEXT:
> +               context->u.app_ctx.provider_name =3D
> +                       opt->u.app_ctx.provider_name;
> +               context->u.app_ctx.ctx_name =3D
> +                       opt->u.app_ctx.ctx_name;
> +               break;
> +       default:
> +               break;
> +       }
> +}
> +
> +/*
> + * Pretty print context type.
> + */
> +static int print_ctx_type(void)
> +{
> +
> +       FILE *ofp =3D stdout;
> +       int i =3D 0;
> +       int ret;
> +       struct lttng_event_context context;
> +
> +       memset(&context, 0, sizeof(context));
> +
> +       ret =3D mi_open();
> +       if (ret) {
> +               ret =3D CMD_ERROR;
> +               goto end;
> +       }
> +
> +       if (lttng_opt_mi) {
> +               /* Open a contexts element */
> +               ret =3D mi_lttng_writer_open_element(writer,
> config_element_contexts);
> +               if (ret) {
> +                       ret =3D CMD_ERROR;
> +                       goto end;
> +               }
> +       }
> +
> +       while (ctx_opts[i].symbol !=3D NULL) {
> +               if (!ctx_opts[i].hide_help) {
> +                       if (lttng_opt_mi) {
> +                               populate_context(&context, &ctx_opts[i]);
> +                               ret =3D mi_lttng_context(writer, &context=
,
> 1);
> +                               if (ret) {
> +                                       ret =3D CMD_ERROR;
> +                                       goto end;
> +                               }
> +
> +                               ret =3D mi_lttng_writer_write_element_
> string(
> +                                               writer,
> +                                               mi_lttng_element_context_
> symbol,
> +                                               ctx_opts[i].symbol);
> +                               if (ret) {
> +                                       ret =3D CMD_ERROR;
> +                                       goto end;
> +                               }
> +
> +                               ret =3D mi_lttng_writer_close_element(
> writer);
> +                               if (ret) {
> +                                       ret =3D CMD_ERROR;
> +                                       goto end;
> +                               }
> +                       } else {
> +                               fprintf(ofp, "%s\n", ctx_opts[i].symbol);
> +                       }
> +               }
> +               i++;
> +       }
> +
> +       if (lttng_opt_mi) {
> +               /* Close contexts element */
> +               ret =3D mi_lttng_writer_close_element(writer);
> +               if (ret) {
> +                       goto end;
> +               }
> +       }
> +
> +end:
> +       ret =3D mi_close(ret);
> +       if (ret) {
> +               ret =3D CMD_ERROR;
> +       }
> +       return ret;
> +}
> +
>  /*
>   * Add context to channel or event.
>   */
> @@ -544,7 +715,6 @@ static int add_context(char *session_name)
>         struct lttng_event_context context;
>         struct lttng_domain dom;
>         struct ctx_type *type;
> -       char *ptr;
>
>         memset(&context, 0, sizeof(context));
>         memset(&dom, 0, sizeof(dom));
> @@ -566,35 +736,10 @@ static int add_context(char *session_name)
>
>         /* Iterate over all the context types given */
>         cds_list_for_each_entry(type, &ctx_type_list.head, list) {
> -               context.ctx =3D (enum lttng_event_context_type)
> type->opt->ctx_type;
> -               switch (context.ctx) {
> -               case LTTNG_EVENT_CONTEXT_PERF_COUNTER:
> -               case LTTNG_EVENT_CONTEXT_PERF_CPU_COUNTER:
> -               case LTTNG_EVENT_CONTEXT_PERF_THREAD_COUNTER:
> -                       context.u.perf_counter.type =3D
> type->opt->u.perf.type;
> -                       context.u.perf_counter.config =3D
> type->opt->u.perf.config;
> -                       strncpy(context.u.perf_counter.name,
> type->opt->symbol,
> -                               LTTNG_SYMBOL_NAME_LEN);
> -                       context.u.perf_counter.name[LTTNG_SYMBOL_NAME_LEN
> - 1] =3D '\0';
> -                       /* Replace : and - by _ */
> -                       while ((ptr =3D strchr(context.u.perf_counter.nam=
e,
> '-')) !=3D NULL) {
> -                               *ptr =3D '_';
> -                       }
> -                       while ((ptr =3D strchr(context.u.perf_counter.nam=
e,
> ':')) !=3D NULL) {
> -                               *ptr =3D '_';
> -                       }
> -                       break;
> -               case LTTNG_EVENT_CONTEXT_APP_CONTEXT:
> -                       context.u.app_ctx.provider_name =3D
> -                                       type->opt->u.app_ctx.provider_
> name;
> -                       context.u.app_ctx.ctx_name =3D
> -                                       type->opt->u.app_ctx.ctx_name;
> -                       break;
> -               default:
> -                       break;
> -               }
>                 DBG("Adding context...");
>
> +               populate_context(&context, type->opt);
> +
>                 if (lttng_opt_mi) {
>                         /* We leave context open the update the success o=
f
> the command */
>                         ret =3D mi_lttng_context(writer, &context, 1);
> @@ -602,6 +747,14 @@ static int add_context(char *session_name)
>                                 ret =3D CMD_ERROR;
>                                 goto error;
>                         }
> +
> +                       ret =3D mi_lttng_writer_write_element_string(writ=
er,
> +                                       mi_lttng_element_context_symbol,
> +                                       type->opt->symbol);
> +                       if (ret) {
> +                               ret =3D CMD_ERROR;
> +                               goto error;
> +                       }
>                 }
>
>                 ret =3D lttng_add_context(handle, &context, NULL,
> opt_channel_name);
> @@ -894,7 +1047,6 @@ not_found:
>  int cmd_add_context(int argc, const char **argv)
>  {
>         int opt, ret =3D CMD_SUCCESS, command_ret =3D CMD_SUCCESS;
> -       int success =3D 1;
>         static poptContext pc;
>         struct ctx_type *type, *tmptype;
>         char *session_name =3D NULL;
> @@ -913,7 +1065,7 @@ int cmd_add_context(int argc, const char **argv)
>                         SHOW_HELP();
>                         goto end;
>                 case OPT_LIST:
> -                       print_ctx_type(stdout);
> +                       ret =3D print_ctx_type();
>                         goto end;
>                 case OPT_TYPE:
>                 {
> @@ -967,59 +1119,15 @@ int cmd_add_context(int argc, const char **argv)
>                 session_name =3D opt_session_name;
>         }
>
> -       /* Mi check */
> -       if (lttng_opt_mi) {
> -               writer =3D mi_lttng_writer_create(fileno(stdout),
> lttng_opt_mi);
> -               if (!writer) {
> -                       ret =3D -LTTNG_ERR_NOMEM;
> -                       goto end;
> -               }
> -
> -               /* Open command element */
> -               ret =3D mi_lttng_writer_command_open(writer,
> -                               mi_lttng_element_command_add_context);
> -               if (ret) {
> -                       ret =3D CMD_ERROR;
> -                       goto end;
> -               }
> -
> -               /* Open output element */
> -               ret =3D mi_lttng_writer_open_element(writer,
> -                               mi_lttng_element_command_output);
> -               if (ret) {
> -                       ret =3D CMD_ERROR;
> -                       goto end;
> -               }
> +       ret =3D mi_open();
> +       if (ret) {
> +               goto end;
>         }
>
>         command_ret =3D add_context(session_name);
> -       if (command_ret) {
> -               success =3D 0;
> -       }
> -
> -       /* Mi closing */
> -       if (lttng_opt_mi) {
> -               /* Close  output element */
> -               ret =3D mi_lttng_writer_close_element(writer);
> -               if (ret) {
> -                       ret =3D CMD_ERROR;
> -                       goto end;
> -               }
> -
> -               /* Success ? */
> -               ret =3D mi_lttng_writer_write_element_bool(writer,
> -                               mi_lttng_element_command_success,
> success);
> -               if (ret) {
> -                       ret =3D CMD_ERROR;
> -                       goto end;
> -               }
> -
> -               /* Command element close */
> -               ret =3D mi_lttng_writer_command_close(writer);
> -               if (ret) {
> -                       ret =3D CMD_ERROR;
> -                       goto end;
> -               }
> +       ret =3D mi_close(command_ret);
> +       if (ret) {
> +               goto end;
>         }
>
>  end:
> diff --git a/src/common/mi-lttng-3.0.xsd b/src/common/mi-lttng-3.0.xsd
> index ae00ee8..a2827a9 100644
> --- a/src/common/mi-lttng-3.0.xsd
> +++ b/src/common/mi-lttng-3.0.xsd
> @@ -480,11 +480,14 @@ THE SOFTWARE.
>
>         <!-- Maps to lttng_event_context -->
>         <xs:complexType name=3D"context_type">
> -               <xs:choice>
> -                       <xs:element name=3D"type"
> type=3D"tns:context_type_type"/>
> -                       <xs:element name=3D"perf" type=3D"tns:perf_counte=
r_
> context_type"/>
> -                       <xs:element name=3D"app"
> type=3D"tns:app_context_type"/>
> -               </xs:choice>
> +               <xs:sequence>
> +                       <xs:choice>
> +                               <xs:element name=3D"type"
> type=3D"tns:context_type_type"/>
> +                               <xs:element name=3D"perf"
> type=3D"tns:perf_counter_context_type"/>
> +                               <xs:element name=3D"app"
> type=3D"tns:app_context_type"/>
> +                       </xs:choice>
> +                       <xs:element name=3D"symbol" type=3D"xs:string"
> minOccurs=3D"0" />
> +               </xs:sequence>
>         </xs:complexType>
>
>         <!-- Maps to an array of domain -->
> diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c
> index f0244d9..4e80c0c 100644
> --- a/src/common/mi-lttng.c
> +++ b/src/common/mi-lttng.c
> @@ -179,6 +179,9 @@ const char * const mi_lttng_element_snapshots =3D
> "snapshots";
>  /* String related to track/untrack command */
>  const char * const mi_lttng_element_track_untrack_all_wildcard =3D "*";
>
> +/* String related to add-context command */
> +LTTNG_HIDDEN const char * const mi_lttng_element_context_symbol =3D
> "symbol";
> +
>  /* Deprecated symbols preserved for ABI compatibility. */
>  const char * const mi_lttng_context_type_perf_counter;
>  const char * const mi_lttng_context_type_perf_cpu_counter;
> diff --git a/src/common/mi-lttng.h b/src/common/mi-lttng.h
> index e7cf8af..cddaf02 100644
> --- a/src/common/mi-lttng.h
> +++ b/src/common/mi-lttng.h
> @@ -185,6 +185,9 @@ extern const char * const mi_lttng_element_snapshots;
>  /* String related to track/untrack command */
>  const char * const mi_lttng_element_track_untrack_all_wildcard;
>
> +/* String related to add-context command */
> +LTTNG_HIDDEN extern const char * const mi_lttng_element_context_symbol;
> +
>  /* Utility string function  */
>  const char *mi_lttng_loglevel_string(int value, enum lttng_domain_type
> domain);
>  const char *mi_lttng_logleveltype_string(enum lttng_loglevel_type value)=
;
> diff --git a/tests/regression/tools/mi/test_mi
> b/tests/regression/tools/mi/test_mi
> index 0d3bd4f..3509da1 100755
> --- a/tests/regression/tools/mi/test_mi
> +++ b/tests/regression/tools/mi/test_mi
> @@ -59,7 +59,7 @@ DEVNULL=3D/dev/null 2>&1
>
>  DIR=3D$(readlink -f $TESTDIR)
>
> -NUM_TESTS=3D228
> +NUM_TESTS=3D230
>
>  source $TESTDIR/utils/utils.sh
>
> @@ -878,6 +878,18 @@ function test_track_untrack ()
>         destroy_lttng_sessions
>  }
>
> +function test_add_context_list()
> +{
> +       diag "Test context listing"
> +
> +       OUTPUT_FILE=3D"list-context.xml"
> +       OUTPUT_DEST=3D$OUTPUT_DIR/$OUTPUT_FILE
> +       lttng_add_context_list
> +
> +       $XML_VALIDATE $OUTPUT_DEST
> +       ok $? "Mi test: context listing validation"
> +}
> +
>  start_lttng_sessiond $FOO_LOAD_DIR
>  TESTS=3D(
>         test_version
> @@ -894,6 +906,7 @@ TESTS=3D(
>         test_snapshot
>         test_track_untrack
>         test_list_session_long_path
> +       test_add_context_list
>  )
>
>
> diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
> index ab04979..0c51ac3 100644
> --- a/tests/utils/utils.sh
> +++ b/tests/utils/utils.sh
> @@ -1318,6 +1318,13 @@ function lttng_untrack_kernel_all_ok()
>         ok $? "Lttng untrack all pid on the kernel domain"
>  }
>
> +function lttng_add_context_list()
> +{
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN add-context --list 1>
> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
> +       ret=3D$?
> +       ok $ret "Context listing"
> +}
> +
>  function add_context_lttng()
>  {
>         local expected_to_fail=3D"$1"
> --
> 2.7.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--000000000000f641f7056d2f7d22
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5NZXJnZWQgaW4gbWFzdGVyIHdpdGggc29tZSBzbWFsbCBjaGFu
Z2VzLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzITwvZGl2PjxkaXY+SsOpcsOpbWll
PGJyPjwvZGl2PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFzcz0i
Z21haWxfcXVvdGUiPk9uIDI4IEZlYnJ1YXJ5IDIwMTggYXQgMTY6MDYsIEpvbmF0aGFuIFJham90
dGUgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86am9uYXRoYW4ucmFqb3R0ZS1q
dWxpZW5AZWZmaWNpb3MuY29tIiB0YXJnZXQ9Il9ibGFuayI+am9uYXRoYW4ucmFqb3R0ZS1qdWxp
ZW5AZWZmaWNpb3MuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFz
cz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHgg
I2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5UaGUgc3ltYm9sIGVsZW1lbnQgaXMgdGhlIHN0
cmluZyBwYXNzZWQvdG8gYmUgcGFzc2VkIG9uIHRoZSBjbGk8YnI+DQpmb3IgdGhlIC0tdHlwZSBv
cHRpb24uPGJyPg0KPGJyPg0KU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0ZSAmbHQ7PGEg
aHJlZj0ibWFpbHRvOmpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbSI+am9uYXRo
YW4ucmFqb3R0ZS1qdWxpZW5APHdicj5lZmZpY2lvcy5jb208L2E+Jmd0Ozxicj4NCi0tLTxicj4N
CnYyOjxicj4NCsKgIMKgIE1pIC0mZ3Q7IE1JICgyeCk8YnI+DQrCoCDCoCBNaXNzaW5nIGVtcHR5
IGxpbmUgYWZ0ZXIgdmFyaWFibGUgZGVjbGFyYXRpb24gYXQgdG9wIG9mIGZ1bmN0aW9uICgyeCk8
YnI+DQrCoCDCoCBtaV9vcGVuKCkgLSZndDsgbWlfb3Blbih2b2lkKTxicj4NCsKgIMKgIENoZWNr
IGVycm9yIG9uIGZpbGVubygpPGJyPg0KwqAgwqAgbWlfY2xvc2UgYXJndW1lbnQgaXMgbm93IGFu
IGVudW0gY21kX2Vycl9jb2RlPGJyPg0KPGJyPg0KLS0tPGJyPg0KwqBzcmMvYmluL2x0dG5nL2Nv
bW1hbmRzL2FkZF88d2JyPmNvbnRleHQuYyB8IDI5NCArKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS08d2JyPi0tLS0tPGJyPg0KwqBzcmMvY29tbW9uL21pLWx0dG5nLTMuMC54c2TCoCDCoCDC
oCDCoCDCoCB8wqAgMTMgKy08YnI+DQrCoHNyYy9jb21tb24vbWktbHR0bmcuY8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHzCoCDCoDMgKzxicj4NCsKgc3JjL2NvbW1vbi9taS1sdHRuZy5owqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMyArPGJyPg0KwqB0ZXN0cy9yZWdyZXNzaW9uL3Rvb2xz
L21pLzx3YnI+dGVzdF9tacKgIMKgIHzCoCAxNSArLTxicj4NCsKgdGVzdHMvdXRpbHMvdXRpbHMu
c2jCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDcgKzxicj4NCsKgNiBmaWxlcyBjaGFu
Z2VkLCAyMzYgaW5zZXJ0aW9ucygrKSwgOTkgZGVsZXRpb25zKC0pPGJyPg0KPGJyPg0KZGlmZiAt
LWdpdCBhL3NyYy9iaW4vbHR0bmcvY29tbWFuZHMvYWRkXzx3YnI+Y29udGV4dC5jIGIvc3JjL2Jp
bi9sdHRuZy9jb21tYW5kcy9hZGRfPHdicj5jb250ZXh0LmM8YnI+DQppbmRleCAyMDlhOWY0Li45
NWM4MzRjIDEwMDY0NDxicj4NCi0tLSBhL3NyYy9iaW4vbHR0bmcvY29tbWFuZHMvYWRkXzx3YnI+
Y29udGV4dC5jPGJyPg0KKysrIGIvc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy9hZGRfPHdicj5jb250
ZXh0LmM8YnI+DQpAQCAtNDgyLDIwICs0ODIsNyBAQCBzdHJ1Y3QgY3R4X3R5cGVfbGlzdCB7PGJy
Pg0KwqAgwqAgwqAgwqAgLmhlYWQgPSBDRFNfTElTVF9IRUFEX0lOSVQoY3R4X3R5cGVfPHdicj5s
aXN0LmhlYWQpLDxicj4NCsKgfTs8YnI+DQo8YnI+DQotLyo8YnI+DQotICogUHJldHR5IHByaW50
IGNvbnRleHQgdHlwZS48YnI+DQotICovPGJyPg0KLXN0YXRpYyB2b2lkIHByaW50X2N0eF90eXBl
KEZJTEUgKm9mcCk8YnI+DQotezxicj4NCi3CoCDCoCDCoCDCoGludCBpID0gMDs8YnI+DQo8YnI+
DQotwqAgwqAgwqAgwqB3aGlsZSAoY3R4X29wdHNbaV0uc3ltYm9sICE9IE5VTEwpIHs8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoIWN0eF9vcHRzW2ldLmhpZGVfaGVscCkgezxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZwcmludGYob2ZwLCAmcXVvdDsl
c1xuJnF1b3Q7LCBjdHhfb3B0c1tpXS5zeW1ib2wpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoH08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpKys7PGJyPg0KLcKgIMKgIMKgIMKg
fTxicj4NCi19PGJyPg0KPGJyPg0KwqAvKjxicj4NCsKgICogRmluZCBjb250ZXh0IG51bWVyaWNh
bCB2YWx1ZSBmcm9tIHN0cmluZy48YnI+DQpAQCAtNTM1LDYgKzUyMiwxOTAgQEAgZW51bSBsdHRu
Z19kb21haW5fdHlwZSBnZXRfZG9tYWluKHZvaWQpPGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCsKg
fTxicj4NCjxicj4NCitzdGF0aWMgaW50IG1pX29wZW4odm9pZCk8YnI+DQorezxicj4NCivCoCDC
oCDCoCDCoGludCByZXQ7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoC8qIE1JIGNoZWNrICovPGJy
Pg0KK8KgIMKgIMKgIMKgaWYgKCFsdHRuZ19vcHRfbWkpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXQgPSAwOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZW5kOzxi
cj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgcmV0ID0gZmlsZW5vKHN0
ZG91dCk7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKHJldCAmbHQ7IDApIHs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBQRVJST1IoJnF1b3Q7ZmlsZW5vIG9uIHN0ZG91dCZxdW90Oyk7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gQ01EX0VSUk9SOzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGdvdG8gZW5kOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8Kg
IMKgIMKgIMKgd3JpdGVyID0gbWlfbHR0bmdfd3JpdGVyX2NyZWF0ZShyZXQsIGx0dG5nX29wdF9t
aSk7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKCF3cml0ZXIpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXQgPSAtTFRUTkdfRVJSX05PTUVNOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGdvdG8gZW5kOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKg
LyogT3BlbiBjb21tYW5kIGVsZW1lbnQgKi88YnI+DQorwqAgwqAgwqAgwqByZXQgPSBtaV9sdHRu
Z193cml0ZXJfY29tbWFuZF9vcGVuKDx3YnI+d3JpdGVyLDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoG1pX2x0dG5nX2VsZW1lbnRfY29tbWFuZF9hZGRfPHdicj5jb250
ZXh0KTs8YnI+DQorwqAgwqAgwqAgwqBpZiAocmV0KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmV0ID0gQ01EX0VSUk9SOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8g
ZW5kOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgLyogT3BlbiBv
dXRwdXQgZWxlbWVudCAqLzxicj4NCivCoCDCoCDCoCDCoHJldCA9IG1pX2x0dG5nX3dyaXRlcl9v
cGVuX2VsZW1lbnQoPHdicj53cml0ZXIsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgbWlfbHR0bmdfZWxlbWVudF9jb21tYW5kXzx3YnI+b3V0cHV0KTs8YnI+DQorwqAg
wqAgwqAgwqBpZiAocmV0KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gQ01E
X0VSUk9SOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZW5kOzxicj4NCivCoCDC
oCDCoCDCoH08YnI+DQorZW5kOjxicj4NCivCoCDCoCDCoCDCoHJldHVybiByZXQ7PGJyPg0KK308
YnI+DQorPGJyPg0KK3N0YXRpYyBpbnQgbWlfY2xvc2UoZW51bSBjbWRfZXJyb3JfY29kZSBzdWNj
ZXNzKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgaW50IHJldDs8YnI+DQorPGJyPg0KK8KgIMKg
IMKgIMKgLyogTUkgY2xvc2luZyAqLzxicj4NCivCoCDCoCDCoCDCoGlmICghbHR0bmdfb3B0X21p
KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gMDs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBnb3RvIGVuZDs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKg
IMKgLyogQ2xvc2XCoCBvdXRwdXQgZWxlbWVudCAqLzxicj4NCivCoCDCoCDCoCDCoHJldCA9IG1p
X2x0dG5nX3dyaXRlcl9jbG9zZV9lbGVtZW50KDx3YnI+d3JpdGVyKTs8YnI+DQorwqAgwqAgwqAg
wqBpZiAocmV0KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gQ01EX0VSUk9S
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZW5kOzxicj4NCivCoCDCoCDCoCDC
oH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgLyogU3VjY2VzcyA/ICovPGJyPg0KK8KgIMKgIMKg
IMKgcmV0ID0gbWlfbHR0bmdfd3JpdGVyX3dyaXRlX2VsZW1lbnRfPHdicj5ib29sKHdyaXRlciw8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtaV9sdHRuZ19lbGVtZW50
X2NvbW1hbmRfPHdicj5zdWNjZXNzLCAhc3VjY2Vzcyk7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKHJl
dCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IENNRF9FUlJPUjs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGVuZDs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoC8qIENvbW1hbmQgZWxlbWVudCBjbG9zZSAqLzxicj4NCivCoCDC
oCDCoCDCoHJldCA9IG1pX2x0dG5nX3dyaXRlcl9jb21tYW5kX2Nsb3NlKDx3YnI+d3JpdGVyKTs8
YnI+DQorwqAgwqAgwqAgwqBpZiAocmV0KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cmV0ID0gQ01EX0VSUk9SOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZW5kOzxi
cj4NCivCoCDCoCDCoCDCoH08YnI+DQorZW5kOjxicj4NCivCoCDCoCDCoCDCoHJldHVybiByZXQ7
PGJyPg0KK308YnI+DQorPGJyPg0KK3N0YXRpYyB2b2lkIHBvcHVsYXRlX2NvbnRleHQoc3RydWN0
IGx0dG5nX2V2ZW50X2NvbnRleHQgKmNvbnRleHQsIGNvbnN0IHN0cnVjdCBjdHhfb3B0cyAqb3B0
KTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgY2hhciAqcHRyOzxicj4NCis8YnI+DQorwqAgwqAg
wqAgwqBjb250ZXh0LSZndDtjdHggPSAoZW51bSBsdHRuZ19ldmVudF9jb250ZXh0X3R5cGUpIG9w
dC0mZ3Q7Y3R4X3R5cGU7PGJyPg0KK8KgIMKgIMKgIMKgc3dpdGNoIChjb250ZXh0LSZndDtjdHgp
IHs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIExUVE5HX0VWRU5UX0NPTlRFWFRfUEVSRl88d2JyPkNP
VU5URVI6PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBMVFROR19FVkVOVF9DT05URVhUX1BFUkZfQ1BV
Xzx3YnI+Q09VTlRFUjo8YnI+DQorwqAgwqAgwqAgwqBjYXNlIExUVE5HX0VWRU5UX0NPTlRFWFRf
UEVSRl88d2JyPlRIUkVBRF9DT1VOVEVSOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNv
bnRleHQtJmd0O3UucGVyZl9jb3VudGVyLnR5cGUgPSBvcHQtJmd0O3UucGVyZi50eXBlOzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnRleHQtJmd0O3UucGVyZl9jb3VudGVyLmNvbmZp
ZyA9IG9wdC0mZ3Q7dS5wZXJmLmNvbmZpZzs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBz
dHJuY3B5KGNvbnRleHQtJmd0OzxhIGhyZWY9Imh0dHA6Ly91LnBlcmZfY291bnRlci5uYW1lIiBy
ZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj51LnBlcmZfPHdicj5jb3VudGVyLm5hbWU8
L2E+LCBvcHQtJmd0O3N5bWJvbCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBMVFROR19TWU1CT0xfTkFNRV9MRU4pOzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGNvbnRleHQtJmd0OzxhIGhyZWY9Imh0dHA6Ly91LnBlcmZfY291bnRlci5u
YW1lIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj51LnBlcmZfY291bnRlci5uYW1l
PC9hPls8d2JyPkxUVE5HX1NZTUJPTF9OQU1FX0xFTiAtIDFdID0gJiMzOTtcMCYjMzk7Ozxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIFJlcGxhY2UgOiBhbmQgLSBieSBfICovPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgd2hpbGUgKChwdHIgPSBzdHJjaHIoY29udGV4dC0mZ3Q7
PGEgaHJlZj0iaHR0cDovL3UucGVyZl9jb3VudGVyLm5hbWUiIHJlbD0ibm9yZWZlcnJlciIgdGFy
Z2V0PSJfYmxhbmsiPnUucGVyZl88d2JyPmNvdW50ZXIubmFtZTwvYT4sICYjMzk7LSYjMzk7KSkg
IT0gTlVMTCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCpwdHIg
PSAmIzM5O18mIzM5Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgd2hpbGUgKChwdHIgPSBzdHJjaHIoY29udGV4dC0mZ3Q7PGEgaHJl
Zj0iaHR0cDovL3UucGVyZl9jb3VudGVyLm5hbWUiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJf
YmxhbmsiPnUucGVyZl88d2JyPmNvdW50ZXIubmFtZTwvYT4sICYjMzk7OiYjMzk7KSkgIT0gTlVM
TCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCpwdHIgPSAmIzM5
O18mIzM5Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBMVFROR19FVkVOVF9DT05U
RVhUX0FQUF88d2JyPkNPTlRFWFQ6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29udGV4
dC0mZ3Q7dS5hcHBfY3R4LnByb3ZpZGVyXzx3YnI+bmFtZSA9PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgb3B0LSZndDt1LmFwcF9jdHgucHJvdmlkZXJfbmFtZTs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb250ZXh0LSZndDt1LmFwcF9jdHguY3R4X25hbWUg
PTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG9wdC0mZ3Q7dS5hcHBf
Y3R4LmN0eF9uYW1lOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivC
oCDCoCDCoCDCoGRlZmF1bHQ6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJy
Pg0KK8KgIMKgIMKgIMKgfTxicj4NCit9PGJyPg0KKzxicj4NCisvKjxicj4NCisgKiBQcmV0dHkg
cHJpbnQgY29udGV4dCB0eXBlLjxicj4NCisgKi88YnI+DQorc3RhdGljIGludCBwcmludF9jdHhf
dHlwZSh2b2lkKTxicj4NCit7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoEZJTEUgKm9mcCA9IHN0
ZG91dDs8YnI+DQorwqAgwqAgwqAgwqBpbnQgaSA9IDA7PGJyPg0KK8KgIMKgIMKgIMKgaW50IHJl
dDs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgbHR0bmdfZXZlbnRfY29udGV4dCBjb250ZXh0Ozxi
cj4NCis8YnI+DQorwqAgwqAgwqAgwqBtZW1zZXQoJmFtcDtjb250ZXh0LCAwLCBzaXplb2YoY29u
dGV4dCkpOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqByZXQgPSBtaV9vcGVuKCk7PGJyPg0KK8Kg
IMKgIMKgIMKgaWYgKHJldCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IENN
RF9FUlJPUjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGVuZDs8YnI+DQorwqAg
wqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmIChsdHRuZ19vcHRfbWkpIHs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBPcGVuIGEgY29udGV4dHMgZWxlbWVudCAqLzxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IG1pX2x0dG5nX3dyaXRlcl9vcGVuX2Vs
ZW1lbnQoPHdicj53cml0ZXIsIGNvbmZpZ19lbGVtZW50X2NvbnRleHRzKTs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBpZiAocmV0KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmV0ID0gQ01EX0VSUk9SOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGdvdG8gZW5kOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+
DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHdoaWxlIChjdHhfb3B0c1tp
XS5zeW1ib2wgIT0gTlVMTCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICghY3R4
X29wdHNbaV0uaGlkZV9oZWxwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgaWYgKGx0dG5nX29wdF9taSkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBvcHVsYXRlX2NvbnRleHQoJmFtcDtjb250ZXh0LCAmYW1w
O2N0eF9vcHRzW2ldKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXQgPSBtaV9sdHRuZ19jb250ZXh0KHdyaXRlciwgJmFtcDtjb250ZXh0LCAx
KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
ZiAocmV0KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gQ01EX0VSUk9SOzxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZW5kOzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQor
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0
ID0gbWlfbHR0bmdfd3JpdGVyX3dyaXRlX2VsZW1lbnRfPHdicj5zdHJpbmcoPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgd3JpdGVyLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1pX2x0dG5nX2VsZW1lbnRfY29u
dGV4dF88d2JyPnN5bWJvbCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjdHhfb3B0c1tpXS5zeW1ib2wp
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
IChyZXQpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXQgPSBDTURfRVJST1I7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBlbmQ7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCis8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQg
PSBtaV9sdHRuZ193cml0ZXJfY2xvc2VfZWxlbWVudCg8d2JyPndyaXRlcik7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJldCkgezxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHJldCA9IENNRF9FUlJPUjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGVuZDs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfSBlbHNlIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcHJpbnRmKG9mcCwgJnF1b3Q7JXNcbiZxdW90Oywg
Y3R4X29wdHNbaV0uc3ltYm9sKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGkrKzs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDC
oGlmIChsdHRuZ19vcHRfbWkpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBDbG9z
ZSBjb250ZXh0cyBlbGVtZW50ICovPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0g
bWlfbHR0bmdfd3JpdGVyX2Nsb3NlX2VsZW1lbnQoPHdicj53cml0ZXIpOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGlmIChyZXQpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBnb3RvIGVuZDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0K
K8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorZW5kOjxicj4NCivCoCDCoCDCoCDCoHJldCA9IG1p
X2Nsb3NlKHJldCk7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKHJldCkgezxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJldCA9IENNRF9FUlJPUjs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KK8Kg
IMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+DQorfTxicj4NCis8YnI+DQrCoC8qPGJyPg0KwqAgKiBB
ZGQgY29udGV4dCB0byBjaGFubmVsIG9yIGV2ZW50Ljxicj4NCsKgICovPGJyPg0KQEAgLTU0NCw3
ICs3MTUsNiBAQCBzdGF0aWMgaW50IGFkZF9jb250ZXh0KGNoYXIgKnNlc3Npb25fbmFtZSk8YnI+
DQrCoCDCoCDCoCDCoCBzdHJ1Y3QgbHR0bmdfZXZlbnRfY29udGV4dCBjb250ZXh0Ozxicj4NCsKg
IMKgIMKgIMKgIHN0cnVjdCBsdHRuZ19kb21haW4gZG9tOzxicj4NCsKgIMKgIMKgIMKgIHN0cnVj
dCBjdHhfdHlwZSAqdHlwZTs8YnI+DQotwqAgwqAgwqAgwqBjaGFyICpwdHI7PGJyPg0KPGJyPg0K
wqAgwqAgwqAgwqAgbWVtc2V0KCZhbXA7Y29udGV4dCwgMCwgc2l6ZW9mKGNvbnRleHQpKTs8YnI+
DQrCoCDCoCDCoCDCoCBtZW1zZXQoJmFtcDtkb20sIDAsIHNpemVvZihkb20pKTs8YnI+DQpAQCAt
NTY2LDM1ICs3MzYsMTAgQEAgc3RhdGljIGludCBhZGRfY29udGV4dChjaGFyICpzZXNzaW9uX25h
bWUpPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgLyogSXRlcmF0ZSBvdmVyIGFsbCB0aGUgY29udGV4
dCB0eXBlcyBnaXZlbiAqLzxicj4NCsKgIMKgIMKgIMKgIGNkc19saXN0X2Zvcl9lYWNoX2VudHJ5
KHR5cGUsICZhbXA7Y3R4X3R5cGVfbGlzdC5oZWFkLCBsaXN0KSB7PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgY29udGV4dC5jdHggPSAoZW51bSBsdHRuZ19ldmVudF9jb250ZXh0X3R5cGUp
IHR5cGUtJmd0O29wdC0mZ3Q7Y3R4X3R5cGU7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
c3dpdGNoIChjb250ZXh0LmN0eCkgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2Ug
TFRUTkdfRVZFTlRfQ09OVEVYVF9QRVJGXzx3YnI+Q09VTlRFUjo8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBjYXNlIExUVE5HX0VWRU5UX0NPTlRFWFRfUEVSRl9DUFVfPHdicj5DT1VOVEVS
Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgTFRUTkdfRVZFTlRfQ09OVEVYVF9Q
RVJGXzx3YnI+VEhSRUFEX0NPVU5URVI6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgY29udGV4dC51LnBlcmZfY291bnRlci50eXBlID0gdHlwZS0mZ3Q7b3B0LSZndDt1
LnBlcmYudHlwZTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb250
ZXh0LnUucGVyZl9jb3VudGVyLmNvbmZpZyA9IHR5cGUtJmd0O29wdC0mZ3Q7dS5wZXJmLmNvbmZp
Zzs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJuY3B5KDxhIGhy
ZWY9Imh0dHA6Ly9jb250ZXh0LnUucGVyZl9jb3VudGVyLm5hbWUiIHJlbD0ibm9yZWZlcnJlciIg
dGFyZ2V0PSJfYmxhbmsiPmNvbnRleHQudS5wZXJmXzx3YnI+Y291bnRlci5uYW1lPC9hPiwgdHlw
ZS0mZ3Q7b3B0LSZndDtzeW1ib2wsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgTFRUTkdfU1lNQk9MX05BTUVfTEVOKTs8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YSBocmVmPSJodHRwOi8vY29udGV4dC51LnBlcmZf
Y291bnRlci5uYW1lIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5jb250ZXh0LnUu
cGVyZl9jb3VudGVyLm5hbWU8L2E+Wzx3YnI+TFRUTkdfU1lNQk9MX05BTUVfTEVOIC0gMV0gPSAm
IzM5O1wwJiMzOTs7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyog
UmVwbGFjZSA6IGFuZCAtIGJ5IF8gKi88YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB3aGlsZSAoKHB0ciA9IHN0cmNocig8YSBocmVmPSJodHRwOi8vY29udGV4dC51LnBl
cmZfY291bnRlci5uYW1lIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5jb250ZXh0
LnUucGVyZl9jb3VudGVyLjx3YnI+bmFtZTwvYT4sICYjMzk7LSYjMzk7KSkgIT0gTlVMTCkgezxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCpwdHIg
PSAmIzM5O18mIzM5Ozs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgd2hpbGUgKChwdHIgPSBz
dHJjaHIoPGEgaHJlZj0iaHR0cDovL2NvbnRleHQudS5wZXJmX2NvdW50ZXIubmFtZSIgcmVsPSJu
b3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+Y29udGV4dC51LnBlcmZfY291bnRlci48d2JyPm5h
bWU8L2E+LCAmIzM5OzomIzM5OykpICE9IE5VTEwpIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqcHRyID0gJiMzOTtfJiMzOTs7PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNh
c2UgTFRUTkdfRVZFTlRfQ09OVEVYVF9BUFBfPHdicj5DT05URVhUOjxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnRleHQudS5hcHBfY3R4LnByb3ZpZGVyXzx3YnI+
bmFtZSA9PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgdHlwZS0mZ3Q7b3B0LSZndDt1LmFwcF9jdHgucHJvdmlkZXJfPHdicj5u
YW1lOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnRleHQudS5h
cHBfY3R4LmN0eF9uYW1lID08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0eXBlLSZndDtvcHQtJmd0O3UuYXBwX2N0eC5jdHhf
bmFtZTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZWZhdWx0Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBEQkcoJnF1b3Q7QWRkaW5nIGNvbnRleHQuLi4m
cXVvdDspOzxicj4NCjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBvcHVsYXRlX2NvbnRl
eHQoJmFtcDtjb250ZXh0LCB0eXBlLSZndDtvcHQpOzxicj4NCis8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBpZiAobHR0bmdfb3B0X21pKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgLyogV2UgbGVhdmUgY29udGV4dCBvcGVuIHRoZSB1cGRhdGUgdGhlIHN1
Y2Nlc3Mgb2YgdGhlIGNvbW1hbmQgKi88YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCByZXQgPSBtaV9sdHRuZ19jb250ZXh0KHdyaXRlciwgJmFtcDtjb250ZXh0LCAxKTs8
YnI+DQpAQCAtNjAyLDYgKzc0NywxNCBAQCBzdGF0aWMgaW50IGFkZF9jb250ZXh0KGNoYXIgKnNl
c3Npb25fbmFtZSk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCByZXQgPSBDTURfRVJST1I7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBlcnJvcjs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHJldCA9IG1pX2x0dG5nX3dyaXRlcl93cml0ZV9lbGVtZW50Xzx3YnI+c3RyaW5n
KHdyaXRlciw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBtaV9sdHRuZ19lbGVtZW50X2NvbnRleHRfPHdicj5zeW1ib2wsPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgdHlwZS0mZ3Q7b3B0LSZndDtzeW1ib2wpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGlmIChyZXQpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSBDTURfRVJST1I7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBlcnJvcjs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgfTxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldCA9IGx0dG5nX2Fk
ZF9jb250ZXh0KGhhbmRsZSwgJmFtcDtjb250ZXh0LCBOVUxMLCBvcHRfY2hhbm5lbF9uYW1lKTs8
YnI+DQpAQCAtODk0LDcgKzEwNDcsNiBAQCBub3RfZm91bmQ6PGJyPg0KwqBpbnQgY21kX2FkZF9j
b250ZXh0KGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndik8YnI+DQrCoHs8YnI+DQrCoCDCoCDC
oCDCoCBpbnQgb3B0LCByZXQgPSBDTURfU1VDQ0VTUywgY29tbWFuZF9yZXQgPSBDTURfU1VDQ0VT
Uzs8YnI+DQotwqAgwqAgwqAgwqBpbnQgc3VjY2VzcyA9IDE7PGJyPg0KwqAgwqAgwqAgwqAgc3Rh
dGljIHBvcHRDb250ZXh0IHBjOzxicj4NCsKgIMKgIMKgIMKgIHN0cnVjdCBjdHhfdHlwZSAqdHlw
ZSwgKnRtcHR5cGU7PGJyPg0KwqAgwqAgwqAgwqAgY2hhciAqc2Vzc2lvbl9uYW1lID0gTlVMTDs8
YnI+DQpAQCAtOTEzLDcgKzEwNjUsNyBAQCBpbnQgY21kX2FkZF9jb250ZXh0KGludCBhcmdjLCBj
b25zdCBjaGFyICoqYXJndik8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBTSE9XX0hFTFAoKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBn
b3RvIGVuZDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjYXNlIE9QVF9MSVNUOjxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50X2N0eF90eXBlKHN0ZG91
dCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gcHJpbnRf
Y3R4X3R5cGUoKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3Rv
IGVuZDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjYXNlIE9QVF9UWVBFOjxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+DQpAQCAtOTY3LDU5ICsxMTE5LDE1IEBAIGludCBj
bWRfYWRkX2NvbnRleHQoaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2KTxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHNlc3Npb25fbmFtZSA9IG9wdF9zZXNzaW9uX25hbWU7PGJyPg0KwqAg
wqAgwqAgwqAgfTxicj4NCjxicj4NCi3CoCDCoCDCoCDCoC8qIE1pIGNoZWNrICovPGJyPg0KLcKg
IMKgIMKgIMKgaWYgKGx0dG5nX29wdF9taSkgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHdyaXRlciA9IG1pX2x0dG5nX3dyaXRlcl9jcmVhdGUoZmlsZW5vKDx3YnI+c3Rkb3V0KSwgbHR0
bmdfb3B0X21pKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoIXdyaXRlcikgezxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IC1MVFROR19FUlJf
Tk9NRU07PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBlbmQ7
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAvKiBPcGVuIGNvbW1hbmQgZWxlbWVudCAqLzxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHJldCA9IG1pX2x0dG5nX3dyaXRlcl9jb21tYW5kX29wZW4oPHdicj53cml0ZXIs
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbWlf
bHR0bmdfZWxlbWVudF9jb21tYW5kX2FkZF88d2JyPmNvbnRleHQpOzxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlmIChyZXQpIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXQgPSBDTURfRVJST1I7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgZ290byBlbmQ7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCi08
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBPcGVuIG91dHB1dCBlbGVtZW50ICovPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gbWlfbHR0bmdfd3JpdGVyX29wZW5fZWxl
bWVudCg8d2JyPndyaXRlciw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBtaV9sdHRuZ19lbGVtZW50X2NvbW1hbmRfPHdicj5vdXRwdXQpOzxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXQpIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSBDTURfRVJST1I7PGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBlbmQ7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgfTxicj4NCivCoCDCoCDCoCDCoHJldCA9IG1pX29wZW4oKTs8YnI+DQorwqAgwqAgwqAgwqBp
ZiAocmV0KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBlbmQ7PGJyPg0KwqAg
wqAgwqAgwqAgfTxicj4NCjxicj4NCsKgIMKgIMKgIMKgIGNvbW1hbmRfcmV0ID0gYWRkX2NvbnRl
eHQoc2Vzc2lvbl9uYW1lKTs8YnI+DQotwqAgwqAgwqAgwqBpZiAoY29tbWFuZF9yZXQpIHs8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdWNjZXNzID0gMDs8YnI+DQotwqAgwqAgwqAgwqB9
PGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoC8qIE1pIGNsb3NpbmcgKi88YnI+DQotwqAgwqAgwqAg
wqBpZiAobHR0bmdfb3B0X21pKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogQ2xv
c2XCoCBvdXRwdXQgZWxlbWVudCAqLzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9
IG1pX2x0dG5nX3dyaXRlcl9jbG9zZV9lbGVtZW50KDx3YnI+d3JpdGVyKTs8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBpZiAocmV0KSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmV0ID0gQ01EX0VSUk9SOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGdvdG8gZW5kOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+
DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogU3VjY2VzcyA/ICovPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gbWlfbHR0bmdfd3JpdGVyX3dyaXRlX2VsZW1lbnRf
PHdicj5ib29sKHdyaXRlciw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBtaV9sdHRuZ19lbGVtZW50X2NvbW1hbmRfPHdicj5zdWNjZXNzLCBzdWNj
ZXNzKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocmV0KSB7PGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gQ01EX0VSUk9SOzxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZW5kOzxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoH08YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogQ29t
bWFuZCBlbGVtZW50IGNsb3NlICovPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0g
bWlfbHR0bmdfd3JpdGVyX2NvbW1hbmRfY2xvc2UoPHdicj53cml0ZXIpOzxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGlmIChyZXQpIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXQgPSBDTURfRVJST1I7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZ290byBlbmQ7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4N
CivCoCDCoCDCoCDCoHJldCA9IG1pX2Nsb3NlKGNvbW1hbmRfcmV0KTs8YnI+DQorwqAgwqAgwqAg
wqBpZiAocmV0KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBlbmQ7PGJyPg0K
wqAgwqAgwqAgwqAgfTxicj4NCjxicj4NCsKgZW5kOjxicj4NCmRpZmYgLS1naXQgYS9zcmMvY29t
bW9uL21pLWx0dG5nLTMuMC54c2QgYi9zcmMvY29tbW9uL21pLWx0dG5nLTMuMC54c2Q8YnI+DQpp
bmRleCBhZTAwZWU4Li5hMjgyN2E5IDEwMDY0NDxicj4NCi0tLSBhL3NyYy9jb21tb24vbWktbHR0
bmctMy4wLnhzZDxicj4NCisrKyBiL3NyYy9jb21tb24vbWktbHR0bmctMy4wLnhzZDxicj4NCkBA
IC00ODAsMTEgKzQ4MCwxNCBAQCBUSEUgU09GVFdBUkUuPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAg
Jmx0OyEtLSBNYXBzIHRvIGx0dG5nX2V2ZW50X2NvbnRleHQgLS0mZ3Q7PGJyPg0KwqAgwqAgwqAg
wqAgJmx0O3hzOmNvbXBsZXhUeXBlIG5hbWU9JnF1b3Q7Y29udGV4dF90eXBlJnF1b3Q7Jmd0Ozxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZsdDt4czpjaG9pY2UmZ3Q7PGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0O3hzOmVsZW1lbnQgbmFtZT0mcXVvdDt0
eXBlJnF1b3Q7IHR5cGU9JnF1b3Q7dG5zOmNvbnRleHRfdHlwZV90eXBlJnF1b3Q7LyZndDs8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmbHQ7eHM6ZWxlbWVudCBuYW1l
PSZxdW90O3BlcmYmcXVvdDsgdHlwZT0mcXVvdDt0bnM6cGVyZl9jb3VudGVyXzx3YnI+Y29udGV4
dF90eXBlJnF1b3Q7LyZndDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAmbHQ7eHM6ZWxlbWVudCBuYW1lPSZxdW90O2FwcCZxdW90OyB0eXBlPSZxdW90O3RuczphcHBf
Y29udGV4dF90eXBlJnF1b3Q7LyZndDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmbHQ7
L3hzOmNob2ljZSZndDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmbHQ7eHM6c2VxdWVu
Y2UmZ3Q7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0O3hzOmNo
b2ljZSZndDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAmbHQ7eHM6ZWxlbWVudCBuYW1lPSZxdW90O3R5cGUmcXVvdDsgdHlwZT0mcXVvdDt0bnM6
Y29udGV4dF90eXBlX3R5cGUmcXVvdDsvJmd0Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZsdDt4czplbGVtZW50IG5hbWU9JnF1b3Q7cGVyZiZx
dW90OyB0eXBlPSZxdW90O3RuczpwZXJmX2NvdW50ZXJfPHdicj5jb250ZXh0X3R5cGUmcXVvdDsv
Jmd0Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCZsdDt4czplbGVtZW50IG5hbWU9JnF1b3Q7YXBwJnF1b3Q7IHR5cGU9JnF1b3Q7dG5zOmFwcF9j
b250ZXh0X3R5cGUmcXVvdDsvJmd0Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCZsdDsveHM6Y2hvaWNlJmd0Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCZsdDt4czplbGVtZW50IG5hbWU9JnF1b3Q7c3ltYm9sJnF1b3Q7IHR5cGU9JnF1
b3Q7eHM6c3RyaW5nJnF1b3Q7IG1pbk9jY3Vycz0mcXVvdDswJnF1b3Q7IC8mZ3Q7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0Oy94czpzZXF1ZW5jZSZndDs8YnI+DQrCoCDCoCDCoCDC
oCAmbHQ7L3hzOmNvbXBsZXhUeXBlJmd0Ozxicj4NCjxicj4NCsKgIMKgIMKgIMKgICZsdDshLS0g
TWFwcyB0byBhbiBhcnJheSBvZiBkb21haW4gLS0mZ3Q7PGJyPg0KZGlmZiAtLWdpdCBhL3NyYy9j
b21tb24vbWktbHR0bmcuYyBiL3NyYy9jb21tb24vbWktbHR0bmcuYzxicj4NCmluZGV4IGYwMjQ0
ZDkuLjRlODBjMGMgMTAwNjQ0PGJyPg0KLS0tIGEvc3JjL2NvbW1vbi9taS1sdHRuZy5jPGJyPg0K
KysrIGIvc3JjL2NvbW1vbi9taS1sdHRuZy5jPGJyPg0KQEAgLTE3OSw2ICsxNzksOSBAQCBjb25z
dCBjaGFyICogY29uc3QgbWlfbHR0bmdfZWxlbWVudF9zbmFwc2hvdHMgPSAmcXVvdDtzbmFwc2hv
dHMmcXVvdDs7PGJyPg0KwqAvKiBTdHJpbmcgcmVsYXRlZCB0byB0cmFjay91bnRyYWNrIGNvbW1h
bmQgKi88YnI+DQrCoGNvbnN0IGNoYXIgKiBjb25zdCBtaV9sdHRuZ19lbGVtZW50X3RyYWNrXzx3
YnI+dW50cmFja19hbGxfd2lsZGNhcmQgPSAmcXVvdDsqJnF1b3Q7Ozxicj4NCjxicj4NCisvKiBT
dHJpbmcgcmVsYXRlZCB0byBhZGQtY29udGV4dCBjb21tYW5kICovPGJyPg0KK0xUVE5HX0hJRERF
TiBjb25zdCBjaGFyICogY29uc3QgbWlfbHR0bmdfZWxlbWVudF9jb250ZXh0Xzx3YnI+c3ltYm9s
ID0gJnF1b3Q7c3ltYm9sJnF1b3Q7Ozxicj4NCis8YnI+DQrCoC8qIERlcHJlY2F0ZWQgc3ltYm9s
cyBwcmVzZXJ2ZWQgZm9yIEFCSSBjb21wYXRpYmlsaXR5LiAqLzxicj4NCsKgY29uc3QgY2hhciAq
IGNvbnN0IG1pX2x0dG5nX2NvbnRleHRfdHlwZV9wZXJmXzx3YnI+Y291bnRlcjs8YnI+DQrCoGNv
bnN0IGNoYXIgKiBjb25zdCBtaV9sdHRuZ19jb250ZXh0X3R5cGVfcGVyZl88d2JyPmNwdV9jb3Vu
dGVyOzxicj4NCmRpZmYgLS1naXQgYS9zcmMvY29tbW9uL21pLWx0dG5nLmggYi9zcmMvY29tbW9u
L21pLWx0dG5nLmg8YnI+DQppbmRleCBlN2NmOGFmLi5jZGRhZjAyIDEwMDY0NDxicj4NCi0tLSBh
L3NyYy9jb21tb24vbWktbHR0bmcuaDxicj4NCisrKyBiL3NyYy9jb21tb24vbWktbHR0bmcuaDxi
cj4NCkBAIC0xODUsNiArMTg1LDkgQEAgZXh0ZXJuIGNvbnN0IGNoYXIgKiBjb25zdCBtaV9sdHRu
Z19lbGVtZW50X3NuYXBzaG90czs8YnI+DQrCoC8qIFN0cmluZyByZWxhdGVkIHRvIHRyYWNrL3Vu
dHJhY2sgY29tbWFuZCAqLzxicj4NCsKgY29uc3QgY2hhciAqIGNvbnN0IG1pX2x0dG5nX2VsZW1l
bnRfdHJhY2tfPHdicj51bnRyYWNrX2FsbF93aWxkY2FyZDs8YnI+DQo8YnI+DQorLyogU3RyaW5n
IHJlbGF0ZWQgdG8gYWRkLWNvbnRleHQgY29tbWFuZCAqLzxicj4NCitMVFROR19ISURERU4gZXh0
ZXJuIGNvbnN0IGNoYXIgKiBjb25zdCBtaV9sdHRuZ19lbGVtZW50X2NvbnRleHRfPHdicj5zeW1i
b2w7PGJyPg0KKzxicj4NCsKgLyogVXRpbGl0eSBzdHJpbmcgZnVuY3Rpb27CoCAqLzxicj4NCsKg
Y29uc3QgY2hhciAqbWlfbHR0bmdfbG9nbGV2ZWxfc3RyaW5nKGludCB2YWx1ZSwgZW51bSBsdHRu
Z19kb21haW5fdHlwZSBkb21haW4pOzxicj4NCsKgY29uc3QgY2hhciAqbWlfbHR0bmdfbG9nbGV2
ZWx0eXBlX3N0cmluZyg8d2JyPmVudW0gbHR0bmdfbG9nbGV2ZWxfdHlwZSB2YWx1ZSk7PGJyPg0K
ZGlmZiAtLWdpdCBhL3Rlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvbWkvPHdicj50ZXN0X21pIGIvdGVz
dHMvcmVncmVzc2lvbi90b29scy9taS88d2JyPnRlc3RfbWk8YnI+DQppbmRleCAwZDNiZDRmLi4z
NTA5ZGExIDEwMDc1NTxicj4NCi0tLSBhL3Rlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvbWkvPHdicj50
ZXN0X21pPGJyPg0KKysrIGIvdGVzdHMvcmVncmVzc2lvbi90b29scy9taS88d2JyPnRlc3RfbWk8
YnI+DQpAQCAtNTksNyArNTksNyBAQCBERVZOVUxMPS9kZXYvbnVsbCAyJmd0OyZhbXA7MTxicj4N
Cjxicj4NCsKgRElSPSQocmVhZGxpbmsgLWYgJFRFU1RESVIpPGJyPg0KPGJyPg0KLU5VTV9URVNU
Uz0yMjg8YnI+DQorTlVNX1RFU1RTPTIzMDxicj4NCjxicj4NCsKgc291cmNlICRURVNURElSL3V0
aWxzL3V0aWxzLnNoPGJyPg0KPGJyPg0KQEAgLTg3OCw2ICs4NzgsMTggQEAgZnVuY3Rpb24gdGVz
dF90cmFja191bnRyYWNrICgpPGJyPg0KwqAgwqAgwqAgwqAgZGVzdHJveV9sdHRuZ19zZXNzaW9u
czxicj4NCsKgfTxicj4NCjxicj4NCitmdW5jdGlvbiB0ZXN0X2FkZF9jb250ZXh0X2xpc3QoKTxi
cj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgZGlhZyAmcXVvdDtUZXN0IGNvbnRleHQgbGlzdGluZyZx
dW90Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBPVVRQVVRfRklMRT0mcXVvdDtsaXN0LWNvbnRl
eHQueG1sJnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgT1VUUFVUX0RFU1Q9JE9VVFBVVF9ESVIvJDx3
YnI+T1VUUFVUX0ZJTEU8YnI+DQorwqAgwqAgwqAgwqBsdHRuZ19hZGRfY29udGV4dF9saXN0PGJy
Pg0KKzxicj4NCivCoCDCoCDCoCDCoCRYTUxfVkFMSURBVEUgJE9VVFBVVF9ERVNUPGJyPg0KK8Kg
IMKgIMKgIMKgb2sgJD8gJnF1b3Q7TWkgdGVzdDogY29udGV4dCBsaXN0aW5nIHZhbGlkYXRpb24m
cXVvdDs8YnI+DQorfTxicj4NCis8YnI+DQrCoHN0YXJ0X2x0dG5nX3Nlc3Npb25kICRGT09fTE9B
RF9ESVI8YnI+DQrCoFRFU1RTPSg8YnI+DQrCoCDCoCDCoCDCoCB0ZXN0X3ZlcnNpb248YnI+DQpA
QCAtODk0LDYgKzkwNiw3IEBAIFRFU1RTPSg8YnI+DQrCoCDCoCDCoCDCoCB0ZXN0X3NuYXBzaG90
PGJyPg0KwqAgwqAgwqAgwqAgdGVzdF90cmFja191bnRyYWNrPGJyPg0KwqAgwqAgwqAgwqAgdGVz
dF9saXN0X3Nlc3Npb25fbG9uZ19wYXRoPGJyPg0KK8KgIMKgIMKgIMKgdGVzdF9hZGRfY29udGV4
dF9saXN0PGJyPg0KwqApPGJyPg0KPGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL3Rlc3RzL3V0aWxz
L3V0aWxzLnNoIGIvdGVzdHMvdXRpbHMvdXRpbHMuc2g8YnI+DQppbmRleCBhYjA0OTc5Li4wYzUx
YWMzIDEwMDY0NDxicj4NCi0tLSBhL3Rlc3RzL3V0aWxzL3V0aWxzLnNoPGJyPg0KKysrIGIvdGVz
dHMvdXRpbHMvdXRpbHMuc2g8YnI+DQpAQCAtMTMxOCw2ICsxMzE4LDEzIEBAIGZ1bmN0aW9uIGx0
dG5nX3VudHJhY2tfa2VybmVsX2FsbF9vaygpPGJyPg0KwqAgwqAgwqAgwqAgb2sgJD8gJnF1b3Q7
THR0bmcgdW50cmFjayBhbGwgcGlkIG9uIHRoZSBrZXJuZWwgZG9tYWluJnF1b3Q7PGJyPg0KwqB9
PGJyPg0KPGJyPg0KK2Z1bmN0aW9uIGx0dG5nX2FkZF9jb250ZXh0X2xpc3QoKTxicj4NCit7PGJy
Pg0KK8KgIMKgIMKgIMKgJFRFU1RESVIvLi4vc3JjL2Jpbi9sdHRuZy8kPHdicj5MVFROR19CSU4g
YWRkLWNvbnRleHQgLS1saXN0IDEmZ3Q7ICRPVVRQVVRfREVTVCAyJmd0OyAkRVJST1JfT1VUUFVU
X0RFU1Q8YnI+DQorwqAgwqAgwqAgwqByZXQ9JD88YnI+DQorwqAgwqAgwqAgwqBvayAkcmV0ICZx
dW90O0NvbnRleHQgbGlzdGluZyZxdW90Ozxicj4NCit9PGJyPg0KKzxicj4NCsKgZnVuY3Rpb24g
YWRkX2NvbnRleHRfbHR0bmcoKTxicj4NCsKgezxicj4NCsKgIMKgIMKgIMKgIGxvY2FsIGV4cGVj
dGVkX3RvX2ZhaWw9JnF1b3Q7JDEmcXVvdDs8YnI+DQo8c3BhbiBjbGFzcz0iSE9FblpiIj48Zm9u
dCBjb2xvcj0iIzg4ODg4OCI+LS0gPGJyPg0KMi43LjQ8YnI+DQo8YnI+DQo8L2ZvbnQ+PC9zcGFu
PjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PGJyIGNsZWFyPSJhbGwiPjxicj4tLSA8YnI+PGRpdiBj
bGFzcz0iZ21haWxfc2lnbmF0dXJlIiBkYXRhLXNtYXJ0bWFpbD0iZ21haWxfc2lnbmF0dXJlIj5K
w6lyw6ltaWUgR2FsYXJuZWF1PGJyPkVmZmljaU9TIEluYy48YnI+PGEgaHJlZj0iaHR0cDovL3d3
dy5lZmZpY2lvcy5jb20iIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vd3d3LmVmZmljaW9zLmNvbTwv
YT48L2Rpdj4NCjwvZGl2Pg0K
--000000000000f641f7056d2f7d22--

--===============3476875940807653542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3476875940807653542==--
