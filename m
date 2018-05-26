From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Print consumerd32, 64, ,
	kernel configuration
Date: Sat, 26 May 2018 04:38:38 -0400
Message-ID: <CA+jJMxs6dOD8cmDn2xygB5uUEMQwGn1LmrsTLhq7Wb9jLkKqBg__9529.95743505216$1527323831$gmane$org@mail.gmail.com>
References: <20180518211640.5168-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2050917684402502986=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 40tGkN1FfGz18RR
 for <lttng-dev@lists.lttng.org>; Sat, 26 May 2018 04:39:07 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 18278F4BE
 for <lttng-dev@lists.lttng.org>; Sat, 26 May 2018 04:39:01 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id BC_e93-K8GS4 for <lttng-dev@lists.lttng.org>;
 Sat, 26 May 2018 04:39:00 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 5A562F4B2
 for <lttng-dev@lists.lttng.org>; Sat, 26 May 2018 04:39:00 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id 1Vjn6gqQ6_Ef for <lttng-dev@lists.lttng.org>;
 Sat, 26 May 2018 04:39:00 -0400 (EDT)
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
 by mail.efficios.com (Postfix) with ESMTPSA id E749EF495
 for <lttng-dev@lists.lttng.org>; Sat, 26 May 2018 04:38:59 -0400 (EDT)
Received: by mail-wm0-f46.google.com with SMTP id q4-v6so16671842wmq.1
 for <lttng-dev@lists.lttng.org>; Sat, 26 May 2018 01:38:59 -0700 (PDT)
In-Reply-To: <20180518211640.5168-1-jonathan.rajotte-julien@efficios.com>
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

--===============2050917684402502986==
Content-Type: multipart/alternative; boundary="000000000000d2767a056d17d0cb"

--000000000000d2767a056d17d0cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The title of this patch has an extra comma.

On 18 May 2018 at 17:16, Jonathan Rajotte <
jonathan.rajotte-julien@efficios.com> wrote:

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  src/bin/lttng-sessiond/sessiond-config.c | 49 +++++++++++++++---------
>  1 file changed, 31 insertions(+), 18 deletions(-)
>
> diff --git a/src/bin/lttng-sessiond/sessiond-config.c
> b/src/bin/lttng-sessiond/sessiond-config.c
> index 587f2f82..c0e0fec3 100644
> --- a/src/bin/lttng-sessiond/sessiond-config.c
> +++ b/src/bin/lttng-sessiond/sessiond-config.c
> @@ -501,22 +501,35 @@ void sessiond_config_log(struct sessiond_config
> *config)
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
> -       DBG_NO_LOC("\tapplication socket path:      %s",
> config->apps_unix_sock_path.value ? : "Unknown");
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
> +       DBG_NO_LOC("\tapplication socket path:       %s",
> config->apps_unix_sock_path.value ? : "Unknown");
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
> config->consumerd32_path.value);
> +       DBG_NO_LOC("\tconsumerd32 bin_path:          %s",
> config->consumerd32_bin_path.value);
> +       DBG_NO_LOC("\tconsumerd32 lib dir:           %s",
> config->consumerd32_lib_dir.value);
> +       DBG_NO_LOC("\tconsumerd32 err unix sock path:%s",
> config->consumerd32_err_unix_sock_path.value);
> +       DBG_NO_LOC("\tconsumerd32 cmd unix sock path:%s",
> config->consumerd32_cmd_unix_sock_path.value);
> +       DBG_NO_LOC("\tconsumerd64 path:              %s",
> config->consumerd64_path.value);
> +       DBG_NO_LOC("\tconsumerd64 bin path:          %s",
> config->consumerd64_bin_path.value);
> +       DBG_NO_LOC("\tconsumerd64 lib dir:           %s",
> config->consumerd64_lib_dir.value);
> +       DBG_NO_LOC("\tconsumerd64 err unix sock path:%s",
> config->consumerd64_err_unix_sock_path.value);
> +       DBG_NO_LOC("\tconsumerd64 cmd unix sock path:%s",
> config->consumerd64_cmd_unix_sock_path.value);
> +       DBG_NO_LOC("\tkconsumerd path:               %s",
> config->kconsumerd_path.value);
> +       DBG_NO_LOC("\tkconsumerd err unix sock path: %s",
> config->kconsumerd_err_unix_sock_path.value);
> +       DBG_NO_LOC("\tkconsumerd cmd unix sock path: %s",
> config->kconsumerd_cmd_unix_sock_path.value);
>

Those string values can be NULL. Look at how this is handled for the
existing string options (ternary + place holder). In this case, using
"Unknown" seems appropriate.

Thanks,
J=C3=A9r=C3=A9mie


>  }
> --
> 2.17.0
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--000000000000d2767a056d17d0cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The title of this patch has an extra comma.<br><div><div c=
lass=3D"gmail_extra"><br><div class=3D"gmail_quote">On 18 May 2018 at 17:16=
, Jonathan Rajotte <span dir=3D"ltr">&lt;<a href=3D"mailto:jonathan.rajotte=
-julien@efficios.com" target=3D"_blank">jonathan.rajotte-julien@efficios.co=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Signed-off-by: Jo=
nathan Rajotte &lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com">=
jonathan.rajotte-julien@<wbr>efficios.com</a>&gt;<br>
---<br>
=C2=A0src/bin/lttng-sessiond/<wbr>sessiond-config.c | 49 +++++++++++++++---=
------<br>
=C2=A01 file changed, 31 insertions(+), 18 deletions(-)<br>
<br>
diff --git a/src/bin/lttng-sessiond/<wbr>sessiond-config.c b/src/bin/lttng-=
sessiond/<wbr>sessiond-config.c<br>
index 587f2f82..c0e0fec3 100644<br>
--- a/src/bin/lttng-sessiond/<wbr>sessiond-config.c<br>
+++ b/src/bin/lttng-sessiond/<wbr>sessiond-config.c<br>
@@ -501,22 +501,35 @@ void sessiond_config_log(struct sessiond_config *conf=
ig)<br>
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
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;tracing_group_name.<=
wbr>value ? : &quot;Unknown&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tkmod_probe_list:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;kmod_probes_lis=
t.value ? : &quot;None&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tkmod_extra_<wbr>probe_list:=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;kmod_extra_probes_<wbr>lis=
t.value ? : &quot;None&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\trundir:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, con=
fig-&gt;rundir.value ? : &quot;Unknown&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tapplication socket path:=C2=
=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;apps_unix_sock_path.<wbr>value ? : &=
quot;Unknown&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tclient socket path:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;client_unix_sock_pat=
h.<wbr>value ? : &quot;Unknown&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\twait shm path:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;wait_shm_pat=
h.value ? : &quot;Unknown&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\thealth socket path:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;health_unix_sock_pat=
h.<wbr>value ? : &quot;Unknown&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tLTTNG_UST_CLOCK_<wbr>PLUGIN:=
=C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;lttng_ust_clock_<wbr>plugin=
.value ? : &quot;None&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tpid file path:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;pid_file_pat=
h.value ? : &quot;Unknown&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tlock file path:=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;lock_file_pa=
th.value ? : &quot;Unknown&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tsession load path:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;load_session_path.<wbr=
>value ? : &quot;None&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tagent port file path:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;agent_port_file_path.<wbr>v=
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
<wbr>value ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tkmod_probe_list:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;kmod_prob=
es_list.value ? : &quot;None&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tkmod_extra_<wbr>probe_list:=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;kmod_extra_probes_<w=
br>list.value ? : &quot;None&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\trundir:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, co=
nfig-&gt;rundir.value ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tapplication socket path:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;apps_unix_sock_path.<wbr>value=
 ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tclient socket path:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;client_unix_sock_pa=
th.<wbr>value ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\twait shm path:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;wait_s=
hm_path.value ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\thealth socket path:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;health_unix_sock_pa=
th.<wbr>value ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tLTTNG_UST_CLOCK_<wbr>PLUGIN:=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;lttng_ust_clock_<wbr>plugi=
n.value ? : &quot;None&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tpid file path:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;pid_fi=
le_path.value ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tlock file path:=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;lock_file_p=
ath.value ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tsession load path:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;load_session_pat=
h.<wbr>value ? : &quot;None&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tagent port file path:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;agent_port_file_path.<wbr>=
value ? : &quot;Unknown&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd32 path:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;consumerd32_pat=
h.<wbr>value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd32 bin_path:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;consumerd32_bin_path.<wbr>=
value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd32 lib dir:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;consumerd32_lib_dir.=
<wbr>value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd32 err unix sock pa=
th:%s&quot;, config-&gt;consumerd32_err_unix_<wbr>sock_path.value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd32 cmd unix sock pa=
th:%s&quot;, config-&gt;consumerd32_cmd_unix_<wbr>sock_path.value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd64 path:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;consumerd64_pat=
h.<wbr>value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd64 bin path:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 %s&quot;, config-&gt;consumerd64_bin_path.<wbr>=
value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd64 lib dir:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;consumerd64_lib_dir.=
<wbr>value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd64 err unix sock pa=
th:%s&quot;, config-&gt;consumerd64_err_unix_<wbr>sock_path.value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tconsumerd64 cmd unix sock pa=
th:%s&quot;, config-&gt;consumerd64_cmd_unix_<wbr>sock_path.value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tkconsumerd path:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%s&quot;, config-&gt;kconsumer=
d_path.value)<wbr>;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tkconsumerd err unix sock pat=
h: %s&quot;, config-&gt;kconsumerd_err_unix_<wbr>sock_path.value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_NO_LOC(&quot;\tkconsumerd cmd unix sock pat=
h: %s&quot;, config-&gt;kconsumerd_cmd_unix_<wbr>sock_path.value);<br></blo=
ckquote><div><br></div><div>Those string values can be NULL. Look at how th=
is is handled for the existing string options (ternary + place holder). In =
this case, using &quot;Unknown&quot; seems appropriate.</div><div><br></div=
><div>Thanks,</div><div>J=C3=A9r=C3=A9mie<br></div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
=C2=A0}<br>
<span class=3D"HOEnZb"><font color=3D"#888888">-- <br>
2.17.0<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature" data-smartmail=3D"gmail_signature">J=C3=A9r=C3=A9mie =
Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D=
"_blank">http://www.efficios.com</a></div>
</div></div></div>

--000000000000d2767a056d17d0cb--

--===============2050917684402502986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2050917684402502986==--
