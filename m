From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools v2] Print consumerd32/64/kernel
	configuration
Date: Wed, 30 May 2018 17:42:20 -0400
Message-ID: <CA+jJMxt1cyeFzZ9-gRdTqErF6y0XxwcaxRvF4XGd+GO96URwgw__47916.4828932427$1527716455$gmane$org@mail.gmail.com>
References: <20180528205117.13309-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8691552701896817036=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 40x3wp3vmfz18g1
 for <lttng-dev@lists.lttng.org>; Wed, 30 May 2018 17:42:50 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id D00C522531B
 for <lttng-dev@lists.lttng.org>; Wed, 30 May 2018 17:42:43 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id zItOx3UfkLgm for <lttng-dev@lists.lttng.org>;
 Wed, 30 May 2018 17:42:43 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 3F572225308
 for <lttng-dev@lists.lttng.org>; Wed, 30 May 2018 17:42:43 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id 3O92SFiALqxg for <lttng-dev@lists.lttng.org>;
 Wed, 30 May 2018 17:42:43 -0400 (EDT)
Received: from mail-lf0-f44.google.com (mail-lf0-f44.google.com
 [209.85.215.44])
 by mail.efficios.com (Postfix) with ESMTPSA id AC93E2252DA
 for <lttng-dev@lists.lttng.org>; Wed, 30 May 2018 17:42:42 -0400 (EDT)
Received: by mail-lf0-f44.google.com with SMTP id j13-v6so2137374lfb.13
 for <lttng-dev@lists.lttng.org>; Wed, 30 May 2018 14:42:42 -0700 (PDT)
In-Reply-To: <20180528205117.13309-1-jonathan.rajotte-julien@efficios.com>
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

--===============8691552701896817036==
Content-Type: multipart/alternative; boundary="000000000000f1bb2c056d733a3e"

--000000000000f1bb2c056d733a3e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 28 May 2018 at 16:51, Jonathan Rajotte <jonathan.rajotte-julien@
efficios.com> wrote:

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
> v2:
>  - Fix alignment of verbose, verbose consumer, quiet mode,agent_tcp_port
>  - bin_path -> bin path
>  - Update commit
>  - Use ternary operator and use "Unknown" for NULL values.
>
> Side question:
>
> Was there a reason, except code indentation, that left justification is n=
ot
> used here ('-' printf flag from C99 standard)?
>

Ah, no reason other than my ignorance of those printf() specifiers :-)
I'll probably change the code to make use of it.

The patch looks good and is merged in master. Thanks!
J=C3=A9r=C3=A9mie


>
> ---
>  src/bin/lttng-sessiond/sessiond-config.c | 59 +++++++++++++++---------
>  1 file changed, 36 insertions(+), 23 deletions(-)
>
> diff --git a/src/bin/lttng-sessiond/sessiond-config.c
> b/src/bin/lttng-sessiond/sessiond-config.c
> index 587f2f82..0b540865 100644
> --- a/src/bin/lttng-sessiond/sessiond-config.c
> +++ b/src/bin/lttng-sessiond/sessiond-config.c
> @@ -491,32 +491,45 @@ LTTNG_HIDDEN
>  void sessiond_config_log(struct sessiond_config *config)
>  {
>         DBG_NO_LOC("[sessiond configuration]");
> -       DBG_NO_LOC("\tverbose:                      %i", config->verbose)=
;
> -       DBG_NO_LOC("\tverbose consumer:             %i",
> config->verbose_consumer);
> -       DBG_NO_LOC("\tquiet mode:                   %s", config->quiet ?
> "True" : "False");
> +       DBG_NO_LOC("\tverbose:                       %i", config->verbose=
);
> +       DBG_NO_LOC("\tverbose consumer:              %i",
> config->verbose_consumer);
> +       DBG_NO_LOC("\tquiet mode:                    %s", config->quiet ?
> "True" : "False");
>         if (config->agent_tcp_port.begin =3D=3D config->agent_tcp_port.en=
d) {
> -               DBG_NO_LOC("\tagent_tcp_port:               %i",
> config->agent_tcp_port.begin);
> +               DBG_NO_LOC("\tagent_tcp_port:                %i",
> config->agent_tcp_port.begin);
>         } else {
> -               DBG_NO_LOC("\tagent_tcp_port:               [%i, %i]",
> +               DBG_NO_LOC("\tagent_tcp_port:                [%i, %i]",
>                                 config->agent_tcp_port.begin,
>                                 config->agent_tcp_port.end);
>         }
> -       DBG_NO_LOC("\tapplication socket timeout:   %i",
> config->app_socket_timeout);
> -       DBG_NO_LOC("\tno-kernel:                    %s", config->no_kerne=
l
> ? "True" : "False");
> -       DBG_NO_LOC("\tbackground:                   %s",
> config->background ? "True" : "False");
> -       DBG_NO_LOC("\tdaemonize:                    %s", config->daemoniz=
e
> ? "True" : "False");
> -       DBG_NO_LOC("\tsignal parent on start:       %s",
> config->sig_parent ? "True" : "False");
> -       DBG_NO_LOC("\ttracing group name:           %s",
> config->tracing_group_name.value ? : "Unknown");
> -       DBG_NO_LOC("\tkmod_probe_list:              %s",
> config->kmod_probes_list.value ? : "None");
> -       DBG_NO_LOC("\tkmod_extra_probe_list:        %s",
> config->kmod_extra_probes_list.value ? : "None");
> -       DBG_NO_LOC("\trundir:                       %s",
> config->rundir.value ? : "Unknown");
> -       DBG_NO_LOC("\tapplication socket path:      %s", config->
> apps_unix_sock_path.value ? : "Unknown");
> -       DBG_NO_LOC("\tclient socket path:           %s",
> config->client_unix_sock_path.value ? : "Unknown");
> -       DBG_NO_LOC("\twait shm path:                %s",
> config->wait_shm_path.value ? : "Unknown");
> -       DBG_NO_LOC("\thealth socket path:           %s",
> config->health_unix_sock_path.value ? : "Unknown");
> -       DBG_NO_LOC("\tLTTNG_UST_CLOCK_PLUGIN:       %s",
> config->lttng_ust_clock_plugin.value ? : "None");
> -       DBG_NO_LOC("\tpid file path:                %s",
> config->pid_file_path.value ? : "Unknown");
> -       DBG_NO_LOC("\tlock file path:               %s",
> config->lock_file_path.value ? : "Unknown");
> -       DBG_NO_LOC("\tsession load path:            %s",
> config->load_session_path.value ? : "None");
> -       DBG_NO_LOC("\tagent port file path:         %s",
> config->agent_port_file_path.value ? : "Unknown");
> +       DBG_NO_LOC("\tapplication socket timeout:    %i",
> config->app_socket_timeout);
> +       DBG_NO_LOC("\tno-kernel:                     %s",
> config->no_kernel ? "True" : "False");
> +       DBG_NO_LOC("\tbackground:                    %s",
> config->background ? "True" : "False");
> +       DBG_NO_LOC("\tdaemonize:                     %s",
> config->daemonize ? "True" : "False");
> +       DBG_NO_LOC("\tsignal parent on start:        %s",
> config->sig_parent ? "True" : "False");
> +       DBG_NO_LOC("\ttracing group name:            %s",
> config->tracing_group_name.value ? : "Unknown");
> +       DBG_NO_LOC("\tkmod_probe_list:               %s",
> config->kmod_probes_list.value ? : "None");
> +       DBG_NO_LOC("\tkmod_extra_probe_list:         %s",
> config->kmod_extra_probes_list.value ? : "None");
> +       DBG_NO_LOC("\trundir:                        %s",
> config->rundir.value ? : "Unknown");
> +       DBG_NO_LOC("\tapplication socket path:       %s", config->
> apps_unix_sock_path.value ? : "Unknown");
> +       DBG_NO_LOC("\tclient socket path:            %s",
> config->client_unix_sock_path.value ? : "Unknown");
> +       DBG_NO_LOC("\twait shm path:                 %s",
> config->wait_shm_path.value ? : "Unknown");
> +       DBG_NO_LOC("\thealth socket path:            %s",
> config->health_unix_sock_path.value ? : "Unknown");
> +       DBG_NO_LOC("\tLTTNG_UST_CLOCK_PLUGIN:        %s",
> config->lttng_ust_clock_plugin.value ? : "None");
> +       DBG_NO_LOC("\tpid file path:                 %s",
> config->pid_file_path.value ? : "Unknown");
> +       DBG_NO_LOC("\tlock file path:                %s",
> config->lock_file_path.value ? : "Unknown");
> +       DBG_NO_LOC("\tsession load path:             %s",
> config->load_session_path.value ? : "None");
> +       DBG_NO_LOC("\tagent port file path:          %s",
> config->agent_port_file_path.value ? : "Unknown");
> +       DBG_NO_LOC("\tconsumerd32 path:              %s",
> config->consumerd32_path.value ? : "Unknown");
> +       DBG_NO_LOC("\tconsumerd32 bin path:          %s",
> config->consumerd32_bin_path.value ? : "Unknown");
> +       DBG_NO_LOC("\tconsumerd32 lib dir:           %s", config->
> consumerd32_lib_dir.value ? : "Unknown");
> +       DBG_NO_LOC("\tconsumerd32 err unix sock path:%s",
> config->consumerd32_err_unix_sock_path.value ? : "Unknown");
> +       DBG_NO_LOC("\tconsumerd32 cmd unix sock path:%s",
> config->consumerd32_cmd_unix_sock_path.value ? : "Unknown");
> +       DBG_NO_LOC("\tconsumerd64 path:              %s",
> config->consumerd64_path.value ? : "Unknown");
> +       DBG_NO_LOC("\tconsumerd64 bin path:          %s",
> config->consumerd64_bin_path.value ? : "Unknown");
> +       DBG_NO_LOC("\tconsumerd64 lib dir:           %s", config->
> consumerd64_lib_dir.value ? : "Unknown");
> +       DBG_NO_LOC("\tconsumerd64 err unix sock path:%s",
> config->consumerd64_err_unix_sock_path.value ? : "Unknown");
> +       DBG_NO_LOC("\tconsumerd64 cmd unix sock path:%s",
> config->consumerd64_cmd_unix_sock_path.value ? : "Unknown");
> +       DBG_NO_LOC("\tkconsumerd path:               %s",
> config->kconsumerd_path.value ? : "Unknown");
> +       DBG_NO_LOC("\tkconsumerd err unix sock path: %s",
> config->kconsumerd_err_unix_sock_path.value ? : "Unknown");
> +       DBG_NO_LOC("\tkconsumerd cmd unix sock path: %s",
> config->kconsumerd_cmd_unix_sock_path.value ? : "Unknown");
>  }
> --
> 2.17.0
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--000000000000f1bb2c056d733a3e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 28 May 2018 at 16:51, Jonathan Rajotte <span dir=3D"ltr">&lt;<a href=
=3D"mailto:jonathan.rajotte-julien@efficios.com" target=3D"_blank">jonathan=
.rajotte-julien@<wbr>efficios.com</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mailto:jonath=
an.rajotte-julien@efficios.com" target=3D"_blank">jonathan.rajotte-julien@e=
ffic<wbr>ios.com</a>&gt;<br>
---<br>
v2:<br>
=C2=A0- Fix alignment of verbose, verbose consumer, quiet mode,agent_tcp_po=
rt<br>
=C2=A0- bin_path -&gt; bin path<br>
=C2=A0- Update commit<br>
=C2=A0- Use ternary operator and use &quot;Unknown&quot; for NULL values.<b=
r>
<br>
Side question:<br>
<br>
Was there a reason, except code indentation, that left justification is not=
<br>
used here (&#39;-&#39; printf flag from C99 standard)?<br></blockquote><div=
><br></div><div>Ah, no reason other than my ignorance of those printf() spe=
cifiers :-)</div><div>I&#39;ll probably change the code to make use of it.<=
br></div><div><br></div><div>The patch looks good and is merged in master. =
Thanks!<br></div><div>J=C3=A9r=C3=A9mie<br></div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
<br>
---<br>
=C2=A0src/bin/lttng-sessiond/sessio<wbr>nd-config.c | 59 +++++++++++++++---=
------<br>
=C2=A01 file changed, 36 insertions(+), 23 deletions(-)<br>
<br>
diff --git a/src/bin/lttng-sessiond/sessi<wbr>ond-config.c b/src/bin/lttng-=
sessiond/sessi<wbr>ond-config.c<br>
index 587f2f82..0b540865 100644<br>
--- a/src/bin/lttng-sessiond/sessi<wbr>ond-config.c<br>
+++ b/src/bin/lttng-sessiond/sessi<wbr>ond-config.c<br>
@@ -491,32 +491,45 @@ LTTNG_HIDDEN<br>
=C2=A0void sessiond_config_log(struct sessiond_config *config)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG_NO_LOC(&quot;[sessiond configuration]&quot;=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tverbose:=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %i&quot;, config-&=
gt;verbose);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tverbose consumer:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%i&quot;, config-&gt;verbose_consumer=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tquiet mode:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;qu=
iet ? &quot;True&quot; : &quot;False&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tverbose:=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%i&quot;, co=
nfig-&gt;verbose);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tverbose consumer:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %i&quot;, config-&gt;verbose_consume=
r);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tquiet mode:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;q=
uiet ? &quot;True&quot; : &quot;False&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (config-&gt;agent_tcp_port.begin =3D=3D conf=
ig-&gt;agent_tcp_port.end) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\t=
agent_tcp_port:<wbr>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
%i&quot;, config-&gt;agent_tcp_port.begin);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\t=
agent_tcp_port:<wbr>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 %i&quot;, config-&gt;agent_tcp_port.begin);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\t=
agent_tcp_port:<wbr>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
[%i, %i]&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\t=
agent_tcp_port:<wbr>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 [%i, %i]&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;agent_tcp_port.begin,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;agent_tcp_port.end);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tapplication socket timeout:=
=C2=A0 =C2=A0%i&quot;, config-&gt;app_socket_timeout);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tno-kernel:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;n=
o_kernel ? &quot;True&quot; : &quot;False&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tbackground:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;ba=
ckground ? &quot;True&quot; : &quot;False&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tdaemonize:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;d=
aemonize ? &quot;True&quot; : &quot;False&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tsignal parent on start:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;sig_parent ? &quot;True&quot; =
: &quot;False&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\ttracing group name:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;tracing_group_name.v=
al<wbr>ue ? : &quot;Unknown&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tkmod_probe_<wbr>list:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;kmod_probes_=
list.value ? : &quot;None&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tkmod_extra_prob<wbr>e_list:=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;kmod_extra_probes_list<wbr=
>.value ? : &quot;None&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\trundir:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, con=
fig-&gt;rundir.value ? : &quot;Unknown&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tapplication socket path:=C2=
=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;<a href=3D"http://apps_unix_sock_pat=
h.va">apps_unix_sock_path.va</a><wbr>lue ? : &quot;Unknown&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tclient socket path:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;client_unix_sock_pat=
h.<wbr>value ? : &quot;Unknown&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\twait shm path:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;wait_shm_pat=
h.value ? : &quot;Unknown&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\thealth socket path:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;health_unix_sock_pat=
h.<wbr>value ? : &quot;Unknown&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tLTTNG_UST_<wbr>CLOCK_PLUGIN:=
=C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;lttng_ust_clock_plugin<wbr>=
.value ? : &quot;None&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tpid file path:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;pid_file_pat=
h.value ? : &quot;Unknown&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tlock file path:=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;lock_file_pa=
th.value ? : &quot;Unknown&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tsession load path:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;load_session_path.valu=
<wbr>e ? : &quot;None&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tagent port file path:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;agent_port_file_path.v<wbr>=
alue ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tapplication socket timeout:=
=C2=A0 =C2=A0 %i&quot;, config-&gt;app_socket_timeout);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tno-kernel:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config=
-&gt;no_kernel ? &quot;True&quot; : &quot;False&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tbackground:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;b=
ackground ? &quot;True&quot; : &quot;False&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tdaemonize:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config=
-&gt;daemonize ? &quot;True&quot; : &quot;False&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tsignal parent on start:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;sig_parent ? &quot;True&quot;=
 : &quot;False&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\ttracing group name:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;tracing_group_name.=
val<wbr>ue ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tkmod_probe_<wbr>list:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;kmod_p=
robes_list.value ? : &quot;None&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tkmod_extra_prob<wbr>e_list:=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;kmod_extra_probes_li=
st<wbr>.value ? : &quot;None&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\trundir:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, co=
nfig-&gt;rundir.value ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tapplication socket path:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;<a href=3D"http://apps_unix_so=
ck_path.va">apps_unix_sock_path.va</a><wbr>lue ? : &quot;Unknown&quot;);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tclient socket path:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;client_unix_sock_pa=
th.<wbr>value ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\twait shm path:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;wait_s=
hm_path.value ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\thealth socket path:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;health_unix_sock_pa=
th.<wbr>value ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tLTTNG_UST_<wbr>CLOCK_PLUGIN:=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;lttng_ust_clock_plugin<wbr=
>.value ? : &quot;None&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tpid file path:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;pid_fi=
le_path.value ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tlock file path:=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;lock_file_p=
ath.value ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tsession load path:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;load_session_pat=
h.valu<wbr>e ? : &quot;None&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tagent port file path:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;agent_port_file_path.v<wbr=
>alue ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd32 path:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;consumerd32_pat=
h.value ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd32 bin path:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;consumerd32_bin_path.v<wbr=
>alue ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd32 lib dir:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;<a href=3D"http://co=
nsumerd32_lib_dir.va">consumerd32_lib_dir.va</a><wbr>lue ? : &quot;Unknown&=
quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd32 err unix sock pa=
th:%s&quot;, config-&gt;consumerd32_err_unix_s<wbr>ock_path.value ? : &quot=
;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd32 cmd unix sock pa=
th:%s&quot;, config-&gt;consumerd32_cmd_unix_s<wbr>ock_path.value ? : &quot=
;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd64 path:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;consumerd64_pat=
h.value ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd64 bin path:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;consumerd64_bin_path.v<wbr=
>alue ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd64 lib dir:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;<a href=3D"http://co=
nsumerd64_lib_dir.va">consumerd64_lib_dir.va</a><wbr>lue ? : &quot;Unknown&=
quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd64 err unix sock pa=
th:%s&quot;, config-&gt;consumerd64_err_unix_s<wbr>ock_path.value ? : &quot=
;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd64 cmd unix sock pa=
th:%s&quot;, config-&gt;consumerd64_cmd_unix_s<wbr>ock_path.value ? : &quot=
;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tkconsumerd path:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;kconsumer=
d_path.value ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tkconsumerd err unix sock pat=
h: %s&quot;, config-&gt;kconsumerd_err_unix_so<wbr>ck_path.value ? : &quot;=
Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tkconsumerd cmd unix sock pat=
h: %s&quot;, config-&gt;kconsumerd_cmd_unix_so<wbr>ck_path.value ? : &quot;=
Unknown&quot;);<br>
=C2=A0}<br>
<span class=3D"m_-7940114411399799979HOEnZb"><font color=3D"#888888">-- <br=
>
2.17.0<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"m_-7940114411399799979gmail_signature" data-smartmail=3D"gmail_signatu=
re">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.e=
fficios.com" target=3D"_blank">http://www.efficios.com</a></div>
</div></div>

--000000000000f1bb2c056d733a3e--

--===============8691552701896817036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8691552701896817036==--
