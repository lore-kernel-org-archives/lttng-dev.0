From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: live_test regression on
	large number of cpus
Date: Wed, 29 Apr 2015 15:47:32 -0400
Message-ID: <CA+jJMxsdZqU3cNSsya9qYEJdq_k55K5udp3AMrFMuk-rBeXbMg__34728.6573997282$1430336960$gmane$org@mail.gmail.com>
References: <1430256214-26941-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0446285436=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1YnXxK-0002cL-Ba
 for lttng-dev@lists.lttng.org; Wed, 29 Apr 2015 15:47:49 -0400
Received: by qcrf4 with SMTP id f4so18655280qcr.0
 for <lttng-dev@lists.lttng.org>; Wed, 29 Apr 2015 12:47:33 -0700 (PDT)
In-Reply-To: <1430256214-26941-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============0446285436==
Content-Type: multipart/alternative; boundary=001a113923ea0684e70514e240d9

--001a113923ea0684e70514e240d9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged in master, 2.6 and 2.5.

Thanks!
J=C3=A9r=C3=A9mie

On Tue, Apr 28, 2015 at 5:23 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Merge fixes from Babeltrace lttng-live plugin, especially about
> incorrect use of send() and recv().
>
> Can be triggered with 32 virtual processors visible on the system with
> the root_regression test suite.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  tests/regression/tools/live/live_test.c | 303
> +++++++++++++++++---------------
>  1 file changed, 158 insertions(+), 145 deletions(-)
>
> diff --git a/tests/regression/tools/live/live_test.c
> b/tests/regression/tools/live/live_test.c
> index e30c391..b447733 100644
> --- a/tests/regression/tools/live/live_test.c
> +++ b/tests/regression/tools/live/live_test.c
> @@ -80,6 +80,38 @@ struct live_session {
>  };
>
>  static
> +ssize_t lttng_live_recv(int fd, void *buf, size_t len)
> +{
> +       ssize_t ret;
> +       size_t copied =3D 0, to_copy =3D len;
> +
> +       do {
> +               ret =3D recv(fd, buf + copied, to_copy, 0);
> +               if (ret > 0) {
> +                       assert(ret <=3D to_copy);
> +                       copied +=3D ret;
> +                       to_copy -=3D ret;
> +               }
> +       } while ((ret > 0 && to_copy > 0)
> +               || (ret < 0 && errno =3D=3D EINTR));
> +       if (ret > 0)
> +               ret =3D copied;
> +       /* ret =3D 0 means orderly shutdown, ret < 0 is error. */
> +       return ret;
> +}
> +
> +static
> +ssize_t lttng_live_send(int fd, const void *buf, size_t len)
> +{
> +       ssize_t ret;
> +
> +       do {
> +               ret =3D send(fd, buf, len, MSG_NOSIGNAL);
> +       } while (ret < 0 && errno =3D=3D EINTR);
> +       return ret;
> +}
> +
> +static
>  int connect_viewer(char *hostname)
>  {
>         struct hostent *host;
> @@ -125,7 +157,7 @@ int establish_connection(void)
>  {
>         struct lttng_viewer_cmd cmd;
>         struct lttng_viewer_connect connect;
> -       int ret;
> +       ssize_t ret_len;
>
>         cmd.cmd =3D htobe32(LTTNG_VIEWER_CONNECT);
>         cmd.data_size =3D sizeof(connect);
> @@ -136,32 +168,30 @@ int establish_connection(void)
>         connect.minor =3D htobe32(VERSION_MINOR);
>         connect.type =3D htobe32(LTTNG_VIEWER_CLIENT_COMMAND);
>
> -       do {
> -               ret =3D send(control_sock, &cmd, sizeof(cmd), 0);
> -       } while (ret < 0 && errno =3D=3D EINTR);
> -       if (ret < 0) {
> +       ret_len =3D lttng_live_send(control_sock, &cmd, sizeof(cmd));
> +       if (ret_len < 0) {
>                 fprintf(stderr, "Error sending cmd\n");
>                 goto error;
>         }
> -       do {
> -               ret =3D send(control_sock, &connect, sizeof(connect), 0);
> -       } while (ret < 0 && errno =3D=3D EINTR);
> -       if (ret < 0) {
> +       ret_len =3D lttng_live_send(control_sock, &connect, sizeof(connec=
t));
> +       if (ret_len < 0) {
>                 fprintf(stderr, "Error sending version\n");
>                 goto error;
>         }
>
> -       do {
> -               ret =3D recv(control_sock, &connect, sizeof(connect), 0);
> -       } while (ret < 0 && errno =3D=3D EINTR);
> -       if (ret < 0) {
> +       ret_len =3D lttng_live_recv(control_sock, &connect, sizeof(connec=
t));
> +       if (ret_len =3D=3D 0) {
> +               fprintf(stderr, "[error] Remote side has closed
> connection\n");
> +               goto error;
> +       }
> +       if (ret_len < 0) {
>                 fprintf(stderr, "Error receiving version\n");
>                 goto error;
>         }
> -       ret =3D 0;
> +       return 0;
>
>  error:
> -       return ret;
> +       return -1;
>  }
>
>  /*
> @@ -172,34 +202,33 @@ int list_sessions(int *session_id)
>         struct lttng_viewer_cmd cmd;
>         struct lttng_viewer_list_sessions list;
>         struct lttng_viewer_session lsession;
> -       int i, ret;
> +       int i;
> +       ssize_t ret_len;
>         int first_session =3D 0;
>
>         cmd.cmd =3D htobe32(LTTNG_VIEWER_LIST_SESSIONS);
>         cmd.data_size =3D 0;
>         cmd.cmd_version =3D 0;
>
> -       do {
> -               ret =3D send(control_sock, &cmd, sizeof(cmd), 0);
> -       } while (ret < 0 && errno =3D=3D EINTR);
> -       if (ret < 0) {
> +       ret_len =3D lttng_live_send(control_sock, &cmd, sizeof(cmd));
> +       if (ret_len < 0) {
>                 fprintf(stderr, "Error sending cmd\n");
>                 goto error;
>         }
>
> -       do {
> -               ret =3D recv(control_sock, &list, sizeof(list), 0);
> -       } while (ret < 0 && errno =3D=3D EINTR);
> -       if (ret < 0) {
> +       ret_len =3D lttng_live_recv(control_sock, &list, sizeof(list));
> +       if (ret_len =3D=3D 0) {
> +               fprintf(stderr, "[error] Remote side has closed
> connection\n");
> +               goto error;
> +       }
> +       if (ret_len < 0) {
>                 fprintf(stderr, "Error receiving session list\n");
>                 goto error;
>         }
>
>         for (i =3D 0; i < be32toh(list.sessions_count); i++) {
> -               do {
> -                       ret =3D recv(control_sock, &lsession,
> sizeof(lsession), 0);
> -               } while (ret < 0 && errno =3D=3D EINTR);
> -               if (ret < 0) {
> +               ret_len =3D lttng_live_recv(control_sock, &lsession,
> sizeof(lsession));
> +               if (ret_len < 0) {
>                         fprintf(stderr, "Error receiving session\n");
>                         goto error;
>                 }
> @@ -209,52 +238,48 @@ int list_sessions(int *session_id)
>                 }
>         }
>
> -       ret =3D be32toh(list.sessions_count);
> +       return be32toh(list.sessions_count);
>
>  error:
> -       return ret;
> +       return -1;
>  }
>
> -int create_viewer_session()
> +int create_viewer_session(void)
>  {
>         struct lttng_viewer_cmd cmd;
>         struct lttng_viewer_create_session_response resp;
> -       int ret;
>         ssize_t ret_len;
>
>         cmd.cmd =3D htobe32(LTTNG_VIEWER_CREATE_SESSION);
>         cmd.data_size =3D 0;
>         cmd.cmd_version =3D 0;
>
> -       do {
> -               ret_len =3D send(control_sock, &cmd, sizeof(cmd), 0);
> -       } while (ret_len < 0 && errno =3D=3D EINTR);
> +       ret_len =3D lttng_live_send(control_sock, &cmd, sizeof(cmd));
>         if (ret_len < 0) {
>                 fprintf(stderr, "[error] Error sending cmd\n");
> -               ret =3D ret_len;
>                 goto error;
>         }
>         assert(ret_len =3D=3D sizeof(cmd));
>
> -       do {
> -               ret_len =3D recv(control_sock, &resp, sizeof(resp), 0);
> -       } while (ret_len < 0 && errno =3D=3D EINTR);
> +       ret_len =3D lttng_live_recv(control_sock, &resp, sizeof(resp));
> +       if (ret_len =3D=3D 0) {
> +               fprintf(stderr, "[error] Remote side has closed
> connection\n");
> +               goto error;
> +       }
>         if (ret_len < 0) {
>                 fprintf(stderr, "[error] Error receiving create session
> reply\n");
> -               ret =3D ret_len;
>                 goto error;
>         }
>         assert(ret_len =3D=3D sizeof(resp));
>
>         if (be32toh(resp.status) !=3D LTTNG_VIEWER_CREATE_SESSION_OK) {
>                 fprintf(stderr, "[error] Error creating viewer session\n"=
);
> -               ret =3D -1;
>                 goto error;
>         }
> -       ret =3D 0;
> +       return 0;
>
>  error:
> -       return ret;
> +       return -1;
>  }
>
>  int attach_session(int id)
> @@ -263,11 +288,11 @@ int attach_session(int id)
>         struct lttng_viewer_attach_session_request rq;
>         struct lttng_viewer_attach_session_response rp;
>         struct lttng_viewer_stream stream;
> -       int ret, i;
> +       int i;
> +       ssize_t ret_len;
>
>         session =3D zmalloc(sizeof(struct live_session));
>         if (!session) {
> -               ret =3D -1;
>                 goto error;
>         }
>
> @@ -279,46 +304,44 @@ int attach_session(int id)
>         rq.session_id =3D htobe64(id);
>         rq.seek =3D htobe32(LTTNG_VIEWER_SEEK_BEGINNING);
>
> -       do {
> -               ret =3D send(control_sock, &cmd, sizeof(cmd), 0);
> -       } while (ret < 0 && errno =3D=3D EINTR);
> -       if (ret < 0) {
> +       ret_len =3D lttng_live_send(control_sock, &cmd, sizeof(cmd));
> +       if (ret_len < 0) {
>                 fprintf(stderr, "Error sending cmd\n");
>                 goto error;
>         }
> -       do {
> -               ret =3D send(control_sock, &rq, sizeof(rq), 0);
> -       } while (ret < 0 && errno =3D=3D EINTR);
> -       if (ret < 0) {
> +       ret_len =3D lttng_live_send(control_sock, &rq, sizeof(rq));
> +       if (ret_len < 0) {
>                 fprintf(stderr, "Error sending attach request\n");
>                 goto error;
>         }
>
> -       do {
> -               ret =3D recv(control_sock, &rp, sizeof(rp), 0);
> -       } while (ret < 0 && errno =3D=3D EINTR);
> -       if (ret < 0) {
> +       ret_len =3D lttng_live_recv(control_sock, &rp, sizeof(rp));
> +       if (ret_len =3D=3D 0) {
> +               fprintf(stderr, "[error] Remote side has closed
> connection\n");
> +               goto error;
> +       }
> +       if (ret_len < 0) {
>                 fprintf(stderr, "Error receiving attach response\n");
>                 goto error;
>         }
>         if (be32toh(rp.status) !=3D LTTNG_VIEWER_ATTACH_OK) {
> -               ret =3D -1;
> -               goto end;
> +               goto error;
>         }
>
>         session->stream_count =3D be32toh(rp.streams_count);
>         session->streams =3D zmalloc(session->stream_count *
>                         sizeof(struct viewer_stream));
>         if (!session->streams) {
> -               ret =3D -1;
>                 goto error;
>         }
>
>         for (i =3D 0; i < be32toh(rp.streams_count); i++) {
> -               do {
> -                       ret =3D recv(control_sock, &stream, sizeof(stream=
),
> 0);
> -               } while (ret < 0 && errno =3D=3D EINTR);
> -               if (ret < 0) {
> +               ret_len =3D lttng_live_recv(control_sock, &stream,
> sizeof(stream));
> +               if (ret_len =3D=3D 0) {
> +                       fprintf(stderr, "[error] Remote side has closed
> connection\n");
> +                       goto error;
> +               }
> +               if (ret_len < 0) {
>                         fprintf(stderr, "Error receiving stream\n");
>                         goto error;
>                 }
> @@ -330,7 +353,6 @@ int attach_session(int id)
>                                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>                 if (session->streams[i].mmap_base =3D=3D MAP_FAILED) {
>                         fprintf(stderr, "mmap error\n");
> -                       ret =3D -1;
>                         goto error;
>                 }
>
> @@ -338,11 +360,10 @@ int attach_session(int id)
>                         session->streams[i].metadata_flag =3D 1;
>                 }
>         }
> -       ret =3D session->stream_count;
> +       return session->stream_count;
>
> -end:
>  error:
> -       return ret;
> +       return -1;
>  }
>
>  int get_metadata(void)
> @@ -350,6 +371,7 @@ int get_metadata(void)
>         struct lttng_viewer_cmd cmd;
>         struct lttng_viewer_get_metadata rq;
>         struct lttng_viewer_metadata_packet rp;
> +       ssize_t ret_len;
>         int ret;
>         uint64_t i;
>         char *data =3D NULL;
> @@ -369,30 +391,27 @@ int get_metadata(void)
>
>         if (metadata_stream_id < 0) {
>                 fprintf(stderr, "No metadata stream found\n");
> -               ret =3D -1;
>                 goto error;
>         }
>
>         rq.stream_id =3D htobe64(session->streams[metadata_stream_id].id)=
;
>
> -       do {
> -               ret =3D send(control_sock, &cmd, sizeof(cmd), 0);
> -       } while (ret < 0 && errno =3D=3D EINTR);
> -       if (ret < 0) {
> +       ret_len =3D lttng_live_send(control_sock, &cmd, sizeof(cmd));
> +       if (ret_len < 0) {
>                 fprintf(stderr, "Error sending cmd\n");
>                 goto error;
>         }
> -       do {
> -               ret =3D send(control_sock, &rq, sizeof(rq), 0);
> -       } while (ret < 0 && errno =3D=3D EINTR);
> -       if (ret < 0) {
> +       ret_len =3D lttng_live_send(control_sock, &rq, sizeof(rq));
> +       if (ret_len < 0) {
>                 fprintf(stderr, "Error sending get_metadata request\n");
>                 goto error;
>         }
> -       do {
> -               ret =3D recv(control_sock, &rp, sizeof(rp), 0);
> -       } while (ret < 0 && errno =3D=3D EINTR);
> -       if (ret < 0) {
> +       ret_len =3D lttng_live_recv(control_sock, &rp, sizeof(rp));
> +       if (ret_len =3D=3D 0) {
> +               fprintf(stderr, "[error] Remote side has closed
> connection\n");
> +               goto error;
> +       }
> +       if (ret_len < 0) {
>                 fprintf(stderr, "Error receiving metadata response\n");
>                 goto error;
>         }
> @@ -401,21 +420,19 @@ int get_metadata(void)
>                         break;
>                 case LTTNG_VIEWER_NO_NEW_METADATA:
>                         fprintf(stderr, "NO NEW\n");
> -                       ret =3D -1;
> +                       ret =3D 0;
>                         goto end;
>                 case LTTNG_VIEWER_METADATA_ERR:
>                         fprintf(stderr, "ERR\n");
> -                       ret =3D -1;
> -                       goto end;
> +                       goto error;
>                 default:
>                         fprintf(stderr, "UNKNOWN\n");
> -                       ret =3D -1;
> -                       goto end;
> +                       goto error;
>         }
>
>         len =3D be64toh(rp.len);
>         if (len <=3D 0) {
> -               goto end;
> +               goto error;
>         }
>
>         data =3D zmalloc(len);
> @@ -423,20 +440,24 @@ int get_metadata(void)
>                 PERROR("relay data zmalloc");
>                 goto error;
>         }
> -       do {
> -               ret =3D recv(control_sock, data, len, MSG_WAITALL);
> -       } while (ret < 0 && errno =3D=3D EINTR);
> -       if (ret < 0) {
> +       ret_len =3D lttng_live_recv(control_sock, data, len);
> +       if (ret_len =3D=3D 0) {
> +               fprintf(stderr, "[error] Remote side has closed
> connection\n");
> +               goto error_free_data;
> +       }
> +       if (ret_len < 0) {
>                 fprintf(stderr, "Error receiving trace packet\n");
> -               free(data);
> -               goto error;
> +               goto error_free_data;
>         }
>         free(data);
> -
> -       ret =3D (int) len;
> +       ret =3D len;
>  end:
> -error:
>         return ret;
> +
> +error_free_data:
> +       free(data);
> +error:
> +       return -1;
>  }
>
>  int get_next_index(void)
> @@ -444,7 +465,7 @@ int get_next_index(void)
>         struct lttng_viewer_cmd cmd;
>         struct lttng_viewer_get_next_index rq;
>         struct lttng_viewer_index rp;
> -       int ret;
> +       ssize_t ret_len;
>         int id;
>
>         cmd.cmd =3D htobe32(LTTNG_VIEWER_GET_NEXT_INDEX);
> @@ -455,27 +476,26 @@ int get_next_index(void)
>                 if (session->streams[id].metadata_flag) {
>                         continue;
>                 }
> +               memset(&rq, 0, sizeof(rq));
>                 rq.stream_id =3D htobe64(session->streams[id].id);
>
>  retry:
> -               do {
> -                       ret =3D send(control_sock, &cmd, sizeof(cmd), 0);
> -               } while (ret < 0 && errno =3D=3D EINTR);
> -               if (ret < 0) {
> +               ret_len =3D lttng_live_send(control_sock, &cmd, sizeof(cm=
d));
> +               if (ret_len < 0) {
>                         fprintf(stderr, "Error sending cmd\n");
>                         goto error;
>                 }
> -               do {
> -                       ret =3D send(control_sock, &rq, sizeof(rq), 0);
> -               } while (ret < 0 && errno =3D=3D EINTR);
> -               if (ret < 0) {
> +               ret_len =3D lttng_live_send(control_sock, &rq, sizeof(rq)=
);
> +               if (ret_len < 0) {
>                         fprintf(stderr, "Error sending get_next_index
> request\n");
>                         goto error;
>                 }
> -               do {
> -                       ret =3D recv(control_sock, &rp, sizeof(rp), 0);
> -               } while (ret < 0 && errno =3D=3D EINTR);
> -               if (ret < 0) {
> +               ret_len =3D lttng_live_recv(control_sock, &rp, sizeof(rp)=
);
> +               if (ret_len =3D=3D 0) {
> +                       fprintf(stderr, "[error] Remote side has closed
> connection\n");
> +                       goto error;
> +               }
> +               if (ret_len < 0) {
>                         fprintf(stderr, "Error receiving index
> response\n");
>                         goto error;
>                 }
> @@ -498,11 +518,9 @@ retry:
>                                 break;
>                         case LTTNG_VIEWER_INDEX_ERR:
>                                 fprintf(stderr, "(ERR)\n");
> -                               ret =3D -1;
>                                 goto error;
>                         default:
>                                 fprintf(stderr, "SHOULD NOT HAPPEN\n");
> -                               ret =3D -1;
>                                 goto error;
>                 }
>                 if (!first_packet_stream_id) {
> @@ -511,10 +529,10 @@ retry:
>                         first_packet_stream_id =3D id;
>                 }
>         }
> -       ret =3D 0;
> +       return 0;
>
>  error:
> -       return ret;
> +       return -1;
>  }
>
>  static
> @@ -524,35 +542,34 @@ int get_data_packet(int id, uint64_t offset,
>         struct lttng_viewer_cmd cmd;
>         struct lttng_viewer_get_packet rq;
>         struct lttng_viewer_trace_packet rp;
> -       int ret;
> +       ssize_t ret_len;
>
>         cmd.cmd =3D htobe32(LTTNG_VIEWER_GET_PACKET);
>         cmd.data_size =3D sizeof(rq);
>         cmd.cmd_version =3D 0;
>
> +       memset(&rq, 0, sizeof(rq));
>         rq.stream_id =3D htobe64(session->streams[id].id);
>         /* Already in big endian. */
>         rq.offset =3D offset;
>         rq.len =3D htobe32(len);
>
> -       do {
> -               ret =3D send(control_sock, &cmd, sizeof(cmd), 0);
> -       } while (ret < 0 && errno =3D=3D EINTR);
> -       if (ret < 0) {
> +       ret_len =3D lttng_live_send(control_sock, &cmd, sizeof(cmd));
> +       if (ret_len < 0) {
>                 fprintf(stderr, "Error sending cmd\n");
>                 goto error;
>         }
> -       do {
> -               ret =3D send(control_sock, &rq, sizeof(rq), 0);
> -       } while (ret < 0 && errno =3D=3D EINTR);
> -       if (ret < 0) {
> +       ret_len =3D lttng_live_send(control_sock, &rq, sizeof(rq));
> +       if (ret_len < 0) {
>                 fprintf(stderr, "Error sending get_data_packet request\n"=
);
>                 goto error;
>         }
> -       do {
> -               ret =3D recv(control_sock, &rp, sizeof(rp), 0);
> -       } while (ret < 0 && errno =3D=3D EINTR);
> -       if (ret < 0) {
> +       ret_len =3D lttng_live_recv(control_sock, &rp, sizeof(rp));
> +       if (ret_len =3D=3D 0) {
> +               fprintf(stderr, "[error] Remote side has closed
> connection\n");
> +               goto error;
> +       }
> +       if (ret_len < 0) {
>                 fprintf(stderr, "Error receiving data response\n");
>                 goto error;
>         }
> @@ -560,49 +577,45 @@ int get_data_packet(int id, uint64_t offset,
>
>         switch (be32toh(rp.status)) {
>         case LTTNG_VIEWER_GET_PACKET_OK:
> +               len =3D be32toh(rp.len);
>                 break;
>         case LTTNG_VIEWER_GET_PACKET_RETRY:
>                 fprintf(stderr, "RETRY\n");
> -               ret =3D -1;
> -               goto end;
> +               goto error;
>         case LTTNG_VIEWER_GET_PACKET_ERR:
>                 if (rp.flags & LTTNG_VIEWER_FLAG_NEW_METADATA) {
>                         fprintf(stderr, "NEW_METADATA\n");
> -                       ret =3D 0;
>                         goto end;
>                 }
>                 fprintf(stderr, "ERR\n");
> -               ret =3D -1;
> -               goto end;
> +               goto error;
>         default:
>                 fprintf(stderr, "UNKNOWN\n");
> -               ret =3D -1;
> -               goto end;
> +               goto error;
>         }
>
> -       len =3D be32toh(rp.len);
> -       if (len <=3D 0) {
> -               goto end;
> +       if (len =3D=3D 0) {
> +               goto error;
>         }
>
>         if (len > mmap_size) {
>                 fprintf(stderr, "mmap_size not big enough\n");
> -               ret =3D -1;
>                 goto error;
>         }
>
> -       do {
> -               ret =3D recv(control_sock, session->streams[id].mmap_base=
,
> len, MSG_WAITALL);
> -       } while (ret < 0 && errno =3D=3D EINTR);
> -       if (ret < 0) {
> +       ret_len =3D lttng_live_recv(control_sock,
> session->streams[id].mmap_base, len);
> +       if (ret_len =3D=3D 0) {
> +               fprintf(stderr, "[error] Remote side has closed
> connection\n");
> +               goto error;
> +       }
> +       if (ret_len < 0) {
>                 fprintf(stderr, "Error receiving trace packet\n");
>                 goto error;
>         }
> -       ret =3D len;
> -
>  end:
> +       return 0;
>  error:
> -       return ret;
> +       return -1;
>  }
>
>  int main(int argc, char **argv)
> @@ -638,7 +651,7 @@ int main(int argc, char **argv)
>
>         ret =3D get_data_packet(first_packet_stream_id, first_packet_offs=
et,
>                         first_packet_len);
> -       ok(ret =3D=3D first_packet_len,
> +       ok(ret =3D=3D 0,
>                         "Get one data packet for stream %d, offset %d, le=
n
> %d",
>                         first_packet_stream_id, first_packet_offset,
>                         first_packet_len);
> --
> 2.1.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a113923ea0684e70514e240d9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+TWVyZ2VkIGluIG1hc3RlciwgMi42IGFuZCAyLjUuPGRpdj48YnI+PC9k
aXY+PGRpdj5UaGFua3MhPC9kaXY+PGRpdj5Kw6lyw6ltaWU8L2Rpdj48L2Rpdj48ZGl2IGNsYXNz
PSJnbWFpbF9leHRyYSI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBUdWUsIEFwciAy
OCwgMjAxNSBhdCA1OjIzIFBNLCBNYXRoaWV1IERlc25veWVycyA8c3BhbiBkaXI9Imx0ciI+Jmx0
OzxhIGhyZWY9Im1haWx0bzptYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20iIHRhcmdldD0i
X2JsYW5rIj5tYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb208L2E+Jmd0Ozwvc3Bhbj4gd3Jv
dGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAg
MCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPk1lcmdl
IGZpeGVzIGZyb20gQmFiZWx0cmFjZSBsdHRuZy1saXZlIHBsdWdpbiwgZXNwZWNpYWxseSBhYm91
dDxicj4NCmluY29ycmVjdCB1c2Ugb2Ygc2VuZCgpIGFuZCByZWN2KCkuPGJyPg0KPGJyPg0KQ2Fu
IGJlIHRyaWdnZXJlZCB3aXRoIDMyIHZpcnR1YWwgcHJvY2Vzc29ycyB2aXNpYmxlIG9uIHRoZSBz
eXN0ZW0gd2l0aDxicj4NCnRoZSByb290X3JlZ3Jlc3Npb24gdGVzdCBzdWl0ZS48YnI+DQo8YnI+
DQpTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1IERlc25veWVycyAmbHQ7PGEgaHJlZj0ibWFpbHRvOm1h
dGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbSI+bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3Mu
Y29tPC9hPiZndDs8YnI+DQotLS08YnI+DQrCoHRlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvbGl2ZS9s
aXZlX3Rlc3QuYyB8IDMwMyArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLTxicj4NCsKg
MSBmaWxlIGNoYW5nZWQsIDE1OCBpbnNlcnRpb25zKCspLCAxNDUgZGVsZXRpb25zKC0pPGJyPg0K
PGJyPg0KZGlmZiAtLWdpdCBhL3Rlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvbGl2ZS9saXZlX3Rlc3Qu
YyBiL3Rlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvbGl2ZS9saXZlX3Rlc3QuYzxicj4NCmluZGV4IGUz
MGMzOTEuLmI0NDc3MzMgMTAwNjQ0PGJyPg0KLS0tIGEvdGVzdHMvcmVncmVzc2lvbi90b29scy9s
aXZlL2xpdmVfdGVzdC5jPGJyPg0KKysrIGIvdGVzdHMvcmVncmVzc2lvbi90b29scy9saXZlL2xp
dmVfdGVzdC5jPGJyPg0KQEAgLTgwLDYgKzgwLDM4IEBAIHN0cnVjdCBsaXZlX3Nlc3Npb24gezxi
cj4NCsKgfTs8YnI+DQo8YnI+DQrCoHN0YXRpYzxicj4NCitzc2l6ZV90IGx0dG5nX2xpdmVfcmVj
dihpbnQgZmQsIHZvaWQgKmJ1Ziwgc2l6ZV90IGxlbik8YnI+DQorezxicj4NCivCoCDCoCDCoCDC
oHNzaXplX3QgcmV0Ozxicj4NCivCoCDCoCDCoCDCoHNpemVfdCBjb3BpZWQgPSAwLCB0b19jb3B5
ID0gbGVuOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBkbyB7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcmV0ID0gcmVjdihmZCwgYnVmICsgY29waWVkLCB0b19jb3B5LCAwKTs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocmV0ICZndDsgMCkgezxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFzc2VydChyZXQgJmx0Oz0gdG9fY29weSk7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29waWVkICs9IHJldDs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0b19jb3B5IC09IHJldDs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgfSB3aGlsZSAoKHJldCAm
Z3Q7IDAgJmFtcDsmYW1wOyB0b19jb3B5ICZndDsgMCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB8fCAocmV0ICZsdDsgMCAmYW1wOyZhbXA7IGVycm5vID09IEVJTlRSKSk7PGJyPg0KK8Kg
IMKgIMKgIMKgaWYgKHJldCAmZ3Q7IDApPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0
ID0gY29waWVkOzxicj4NCivCoCDCoCDCoCDCoC8qIHJldCA9IDAgbWVhbnMgb3JkZXJseSBzaHV0
ZG93biwgcmV0ICZsdDsgMCBpcyBlcnJvci4gKi88YnI+DQorwqAgwqAgwqAgwqByZXR1cm4gcmV0
Ozxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0aWM8YnI+DQorc3NpemVfdCBsdHRuZ19saXZlX3Nl
bmQoaW50IGZkLCBjb25zdCB2b2lkICpidWYsIHNpemVfdCBsZW4pPGJyPg0KK3s8YnI+DQorwqAg
wqAgwqAgwqBzc2l6ZV90IHJldDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgZG8gezxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IHNlbmQoZmQsIGJ1ZiwgbGVuLCBNU0dfTk9TSUdO
QUwpOzxicj4NCivCoCDCoCDCoCDCoH0gd2hpbGUgKHJldCAmbHQ7IDAgJmFtcDsmYW1wOyBlcnJu
byA9PSBFSU5UUik7PGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+DQorfTxicj4NCis8
YnI+DQorc3RhdGljPGJyPg0KwqBpbnQgY29ubmVjdF92aWV3ZXIoY2hhciAqaG9zdG5hbWUpPGJy
Pg0KwqB7PGJyPg0KwqAgwqAgwqAgwqAgc3RydWN0IGhvc3RlbnQgKmhvc3Q7PGJyPg0KQEAgLTEy
NSw3ICsxNTcsNyBAQCBpbnQgZXN0YWJsaXNoX2Nvbm5lY3Rpb24odm9pZCk8YnI+DQrCoHs8YnI+
DQrCoCDCoCDCoCDCoCBzdHJ1Y3QgbHR0bmdfdmlld2VyX2NtZCBjbWQ7PGJyPg0KwqAgwqAgwqAg
wqAgc3RydWN0IGx0dG5nX3ZpZXdlcl9jb25uZWN0IGNvbm5lY3Q7PGJyPg0KLcKgIMKgIMKgIMKg
aW50IHJldDs8YnI+DQorwqAgwqAgwqAgwqBzc2l6ZV90IHJldF9sZW47PGJyPg0KPGJyPg0KwqAg
wqAgwqAgwqAgY21kLmNtZCA9IGh0b2JlMzIoTFRUTkdfVklFV0VSX0NPTk5FQ1QpOzxicj4NCsKg
IMKgIMKgIMKgIGNtZC5kYXRhX3NpemUgPSBzaXplb2YoY29ubmVjdCk7PGJyPg0KQEAgLTEzNiwz
MiArMTY4LDMwIEBAIGludCBlc3RhYmxpc2hfY29ubmVjdGlvbih2b2lkKTxicj4NCsKgIMKgIMKg
IMKgIGNvbm5lY3QubWlub3IgPSBodG9iZTMyKFZFUlNJT05fTUlOT1IpOzxicj4NCsKgIMKgIMKg
IMKgIGNvbm5lY3QudHlwZSA9IGh0b2JlMzIoTFRUTkdfVklFV0VSX0NMSUVOVF9DT01NQU5EKTs8
YnI+DQo8YnI+DQotwqAgwqAgwqAgwqBkbyB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cmV0ID0gc2VuZChjb250cm9sX3NvY2ssICZhbXA7Y21kLCBzaXplb2YoY21kKSwgMCk7PGJyPg0K
LcKgIMKgIMKgIMKgfSB3aGlsZSAocmV0ICZsdDsgMCAmYW1wOyZhbXA7IGVycm5vID09IEVJTlRS
KTs8YnI+DQotwqAgwqAgwqAgwqBpZiAocmV0ICZsdDsgMCkgezxicj4NCivCoCDCoCDCoCDCoHJl
dF9sZW4gPSBsdHRuZ19saXZlX3NlbmQoY29udHJvbF9zb2NrLCAmYW1wO2NtZCwgc2l6ZW9mKGNt
ZCkpOzxicj4NCivCoCDCoCDCoCDCoGlmIChyZXRfbGVuICZsdDsgMCkgezxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGZwcmludGYoc3RkZXJyLCAmcXVvdDtFcnJvciBzZW5kaW5nIGNtZFxu
JnF1b3Q7KTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGVycm9yOzxicj4NCsKg
IMKgIMKgIMKgIH08YnI+DQotwqAgwqAgwqAgwqBkbyB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmV0ID0gc2VuZChjb250cm9sX3NvY2ssICZhbXA7Y29ubmVjdCwgc2l6ZW9mKGNvbm5l
Y3QpLCAwKTs8YnI+DQotwqAgwqAgwqAgwqB9IHdoaWxlIChyZXQgJmx0OyAwICZhbXA7JmFtcDsg
ZXJybm8gPT0gRUlOVFIpOzxicj4NCi3CoCDCoCDCoCDCoGlmIChyZXQgJmx0OyAwKSB7PGJyPg0K
K8KgIMKgIMKgIMKgcmV0X2xlbiA9IGx0dG5nX2xpdmVfc2VuZChjb250cm9sX3NvY2ssICZhbXA7
Y29ubmVjdCwgc2l6ZW9mKGNvbm5lY3QpKTs8YnI+DQorwqAgwqAgwqAgwqBpZiAocmV0X2xlbiAm
bHQ7IDApIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmcHJpbnRmKHN0ZGVyciwgJnF1
b3Q7RXJyb3Igc2VuZGluZyB2ZXJzaW9uXG4mcXVvdDspOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGdvdG8gZXJyb3I7PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCjxicj4NCi3CoCDCoCDC
oCDCoGRvIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSByZWN2KGNvbnRyb2xf
c29jaywgJmFtcDtjb25uZWN0LCBzaXplb2YoY29ubmVjdCksIDApOzxicj4NCi3CoCDCoCDCoCDC
oH0gd2hpbGUgKHJldCAmbHQ7IDAgJmFtcDsmYW1wOyBlcnJubyA9PSBFSU5UUik7PGJyPg0KLcKg
IMKgIMKgIMKgaWYgKHJldCAmbHQ7IDApIHs8YnI+DQorwqAgwqAgwqAgwqByZXRfbGVuID0gbHR0
bmdfbGl2ZV9yZWN2KGNvbnRyb2xfc29jaywgJmFtcDtjb25uZWN0LCBzaXplb2YoY29ubmVjdCkp
Ozxicj4NCivCoCDCoCDCoCDCoGlmIChyZXRfbGVuID09IDApIHs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7W2Vycm9yXSBSZW1vdGUgc2lkZSBoYXMg
Y2xvc2VkIGNvbm5lY3Rpb25cbiZxdW90Oyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Z290byBlcnJvcjs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgaWYgKHJldF9s
ZW4gJmx0OyAwKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnByaW50ZihzdGRlcnIs
ICZxdW90O0Vycm9yIHJlY2VpdmluZyB2ZXJzaW9uXG4mcXVvdDspOzxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGdvdG8gZXJyb3I7PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCi3CoCDCoCDC
oCDCoHJldCA9IDA7PGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIDA7PGJyPg0KPGJyPg0KwqBlcnJv
cjo8YnI+DQotwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4NCivCoCDCoCDCoCDCoHJldHVybiAt
MTs8YnI+DQrCoH08YnI+DQo8YnI+DQrCoC8qPGJyPg0KQEAgLTE3MiwzNCArMjAyLDMzIEBAIGlu
dCBsaXN0X3Nlc3Npb25zKGludCAqc2Vzc2lvbl9pZCk8YnI+DQrCoCDCoCDCoCDCoCBzdHJ1Y3Qg
bHR0bmdfdmlld2VyX2NtZCBjbWQ7PGJyPg0KwqAgwqAgwqAgwqAgc3RydWN0IGx0dG5nX3ZpZXdl
cl9saXN0X3Nlc3Npb25zIGxpc3Q7PGJyPg0KwqAgwqAgwqAgwqAgc3RydWN0IGx0dG5nX3ZpZXdl
cl9zZXNzaW9uIGxzZXNzaW9uOzxicj4NCi3CoCDCoCDCoCDCoGludCBpLCByZXQ7PGJyPg0KK8Kg
IMKgIMKgIMKgaW50IGk7PGJyPg0KK8KgIMKgIMKgIMKgc3NpemVfdCByZXRfbGVuOzxicj4NCsKg
IMKgIMKgIMKgIGludCBmaXJzdF9zZXNzaW9uID0gMDs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBj
bWQuY21kID0gaHRvYmUzMihMVFROR19WSUVXRVJfTElTVF9TRVNTSU9OUyk7PGJyPg0KwqAgwqAg
wqAgwqAgY21kLmRhdGFfc2l6ZSA9IDA7PGJyPg0KwqAgwqAgwqAgwqAgY21kLmNtZF92ZXJzaW9u
ID0gMDs8YnI+DQo8YnI+DQotwqAgwqAgwqAgwqBkbyB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmV0ID0gc2VuZChjb250cm9sX3NvY2ssICZhbXA7Y21kLCBzaXplb2YoY21kKSwgMCk7
PGJyPg0KLcKgIMKgIMKgIMKgfSB3aGlsZSAocmV0ICZsdDsgMCAmYW1wOyZhbXA7IGVycm5vID09
IEVJTlRSKTs8YnI+DQotwqAgwqAgwqAgwqBpZiAocmV0ICZsdDsgMCkgezxicj4NCivCoCDCoCDC
oCDCoHJldF9sZW4gPSBsdHRuZ19saXZlX3NlbmQoY29udHJvbF9zb2NrLCAmYW1wO2NtZCwgc2l6
ZW9mKGNtZCkpOzxicj4NCivCoCDCoCDCoCDCoGlmIChyZXRfbGVuICZsdDsgMCkgezxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZwcmludGYoc3RkZXJyLCAmcXVvdDtFcnJvciBzZW5kaW5n
IGNtZFxuJnF1b3Q7KTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGVycm9yOzxi
cj4NCsKgIMKgIMKgIMKgIH08YnI+DQo8YnI+DQotwqAgwqAgwqAgwqBkbyB7PGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gcmVjdihjb250cm9sX3NvY2ssICZhbXA7bGlzdCwgc2l6
ZW9mKGxpc3QpLCAwKTs8YnI+DQotwqAgwqAgwqAgwqB9IHdoaWxlIChyZXQgJmx0OyAwICZhbXA7
JmFtcDsgZXJybm8gPT0gRUlOVFIpOzxicj4NCi3CoCDCoCDCoCDCoGlmIChyZXQgJmx0OyAwKSB7
PGJyPg0KK8KgIMKgIMKgIMKgcmV0X2xlbiA9IGx0dG5nX2xpdmVfcmVjdihjb250cm9sX3NvY2ss
ICZhbXA7bGlzdCwgc2l6ZW9mKGxpc3QpKTs8YnI+DQorwqAgwqAgwqAgwqBpZiAocmV0X2xlbiA9
PSAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnByaW50ZihzdGRlcnIsICZxdW90
O1tlcnJvcl0gUmVtb3RlIHNpZGUgaGFzIGNsb3NlZCBjb25uZWN0aW9uXG4mcXVvdDspOzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJyb3I7PGJyPg0KK8KgIMKgIMKgIMKgfTxi
cj4NCivCoCDCoCDCoCDCoGlmIChyZXRfbGVuICZsdDsgMCkgezxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGZwcmludGYoc3RkZXJyLCAmcXVvdDtFcnJvciByZWNlaXZpbmcgc2Vzc2lvbiBs
aXN0XG4mcXVvdDspOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZXJyb3I7PGJy
Pg0KwqAgwqAgwqAgwqAgfTxicj4NCjxicj4NCsKgIMKgIMKgIMKgIGZvciAoaSA9IDA7IGkgJmx0
OyBiZTMydG9oKGxpc3Quc2Vzc2lvbnNfY291bnQpOyBpKyspIHs8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBkbyB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cmV0ID0gcmVjdihjb250cm9sX3NvY2ssICZhbXA7bHNlc3Npb24sIHNpemVvZihsc2Vzc2lvbiks
IDApOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0gd2hpbGUgKHJldCAmbHQ7IDAgJmFt
cDsmYW1wOyBlcnJubyA9PSBFSU5UUik7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYg
KHJldCAmbHQ7IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXRfbGVuID0gbHR0
bmdfbGl2ZV9yZWN2KGNvbnRyb2xfc29jaywgJmFtcDtsc2Vzc2lvbiwgc2l6ZW9mKGxzZXNzaW9u
KSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJldF9sZW4gJmx0OyAwKSB7PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnByaW50ZihzdGRlcnIsICZx
dW90O0Vycm9yIHJlY2VpdmluZyBzZXNzaW9uXG4mcXVvdDspOzxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZXJyb3I7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgfTxicj4NCkBAIC0yMDksNTIgKzIzOCw0OCBAQCBpbnQgbGlzdF9zZXNzaW9ucyhpbnQg
KnNlc3Npb25faWQpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCsKgIMKgIMKg
IMKgIH08YnI+DQo8YnI+DQotwqAgwqAgwqAgwqByZXQgPSBiZTMydG9oKGxpc3Quc2Vzc2lvbnNf
Y291bnQpOzxicj4NCivCoCDCoCDCoCDCoHJldHVybiBiZTMydG9oKGxpc3Quc2Vzc2lvbnNfY291
bnQpOzxicj4NCjxicj4NCsKgZXJyb3I6PGJyPg0KLcKgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+
DQorwqAgwqAgwqAgwqByZXR1cm4gLTE7PGJyPg0KwqB9PGJyPg0KPGJyPg0KLWludCBjcmVhdGVf
dmlld2VyX3Nlc3Npb24oKTxicj4NCitpbnQgY3JlYXRlX3ZpZXdlcl9zZXNzaW9uKHZvaWQpPGJy
Pg0KwqB7PGJyPg0KwqAgwqAgwqAgwqAgc3RydWN0IGx0dG5nX3ZpZXdlcl9jbWQgY21kOzxicj4N
CsKgIMKgIMKgIMKgIHN0cnVjdCBsdHRuZ192aWV3ZXJfY3JlYXRlX3Nlc3Npb25fcmVzcG9uc2Ug
cmVzcDs8YnI+DQotwqAgwqAgwqAgwqBpbnQgcmV0Ozxicj4NCsKgIMKgIMKgIMKgIHNzaXplX3Qg
cmV0X2xlbjs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBjbWQuY21kID0gaHRvYmUzMihMVFROR19W
SUVXRVJfQ1JFQVRFX1NFU1NJT04pOzxicj4NCsKgIMKgIMKgIMKgIGNtZC5kYXRhX3NpemUgPSAw
Ozxicj4NCsKgIMKgIMKgIMKgIGNtZC5jbWRfdmVyc2lvbiA9IDA7PGJyPg0KPGJyPg0KLcKgIMKg
IMKgIMKgZG8gezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldF9sZW4gPSBzZW5kKGNv
bnRyb2xfc29jaywgJmFtcDtjbWQsIHNpemVvZihjbWQpLCAwKTs8YnI+DQotwqAgwqAgwqAgwqB9
IHdoaWxlIChyZXRfbGVuICZsdDsgMCAmYW1wOyZhbXA7IGVycm5vID09IEVJTlRSKTs8YnI+DQor
wqAgwqAgwqAgwqByZXRfbGVuID0gbHR0bmdfbGl2ZV9zZW5kKGNvbnRyb2xfc29jaywgJmFtcDtj
bWQsIHNpemVvZihjbWQpKTs8YnI+DQrCoCDCoCDCoCDCoCBpZiAocmV0X2xlbiAmbHQ7IDApIHs8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7W2Vycm9y
XSBFcnJvciBzZW5kaW5nIGNtZFxuJnF1b3Q7KTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqByZXQgPSByZXRfbGVuOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZXJyb3I7
PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCsKgIMKgIMKgIMKgIGFzc2VydChyZXRfbGVuID09IHNp
emVvZihjbWQpKTs8YnI+DQo8YnI+DQotwqAgwqAgwqAgwqBkbyB7PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmV0X2xlbiA9IHJlY3YoY29udHJvbF9zb2NrLCAmYW1wO3Jlc3AsIHNpemVv
ZihyZXNwKSwgMCk7PGJyPg0KLcKgIMKgIMKgIMKgfSB3aGlsZSAocmV0X2xlbiAmbHQ7IDAgJmFt
cDsmYW1wOyBlcnJubyA9PSBFSU5UUik7PGJyPg0KK8KgIMKgIMKgIMKgcmV0X2xlbiA9IGx0dG5n
X2xpdmVfcmVjdihjb250cm9sX3NvY2ssICZhbXA7cmVzcCwgc2l6ZW9mKHJlc3ApKTs8YnI+DQor
wqAgwqAgwqAgwqBpZiAocmV0X2xlbiA9PSAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZnByaW50ZihzdGRlcnIsICZxdW90O1tlcnJvcl0gUmVtb3RlIHNpZGUgaGFzIGNsb3NlZCBj
b25uZWN0aW9uXG4mcXVvdDspOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJy
b3I7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCsKgIMKgIMKgIMKgIGlmIChyZXRfbGVuICZsdDsg
MCkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZwcmludGYoc3RkZXJyLCAmcXVvdDtb
ZXJyb3JdIEVycm9yIHJlY2VpdmluZyBjcmVhdGUgc2Vzc2lvbiByZXBseVxuJnF1b3Q7KTs8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSByZXRfbGVuOzxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGdvdG8gZXJyb3I7PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCsKgIMKgIMKg
IMKgIGFzc2VydChyZXRfbGVuID09IHNpemVvZihyZXNwKSk7PGJyPg0KPGJyPg0KwqAgwqAgwqAg
wqAgaWYgKGJlMzJ0b2gocmVzcC5zdGF0dXMpICE9IExUVE5HX1ZJRVdFUl9DUkVBVEVfU0VTU0lP
Tl9PSykgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZwcmludGYoc3RkZXJyLCAmcXVv
dDtbZXJyb3JdIEVycm9yIGNyZWF0aW5nIHZpZXdlciBzZXNzaW9uXG4mcXVvdDspOzxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IC0xOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGdvdG8gZXJyb3I7PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCi3CoCDCoCDCoCDCoHJldCA9
IDA7PGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIDA7PGJyPg0KPGJyPg0KwqBlcnJvcjo8YnI+DQot
wqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4NCivCoCDCoCDCoCDCoHJldHVybiAtMTs8YnI+DQrC
oH08YnI+DQo8YnI+DQrCoGludCBhdHRhY2hfc2Vzc2lvbihpbnQgaWQpPGJyPg0KQEAgLTI2Mywx
MSArMjg4LDExIEBAIGludCBhdHRhY2hfc2Vzc2lvbihpbnQgaWQpPGJyPg0KwqAgwqAgwqAgwqAg
c3RydWN0IGx0dG5nX3ZpZXdlcl9hdHRhY2hfc2Vzc2lvbl9yZXF1ZXN0IHJxOzxicj4NCsKgIMKg
IMKgIMKgIHN0cnVjdCBsdHRuZ192aWV3ZXJfYXR0YWNoX3Nlc3Npb25fcmVzcG9uc2UgcnA7PGJy
Pg0KwqAgwqAgwqAgwqAgc3RydWN0IGx0dG5nX3ZpZXdlcl9zdHJlYW0gc3RyZWFtOzxicj4NCi3C
oCDCoCDCoCDCoGludCByZXQsIGk7PGJyPg0KK8KgIMKgIMKgIMKgaW50IGk7PGJyPg0KK8KgIMKg
IMKgIMKgc3NpemVfdCByZXRfbGVuOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIHNlc3Npb24gPSB6
bWFsbG9jKHNpemVvZihzdHJ1Y3QgbGl2ZV9zZXNzaW9uKSk7PGJyPg0KwqAgwqAgwqAgwqAgaWYg
KCFzZXNzaW9uKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gLTE7PGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBlcnJvcjs8YnI+DQrCoCDCoCDCoCDCoCB9PGJy
Pg0KPGJyPg0KQEAgLTI3OSw0NiArMzA0LDQ0IEBAIGludCBhdHRhY2hfc2Vzc2lvbihpbnQgaWQp
PGJyPg0KwqAgwqAgwqAgwqAgcnEuc2Vzc2lvbl9pZCA9IGh0b2JlNjQoaWQpOzxicj4NCsKgIMKg
IMKgIMKgIHJxLnNlZWsgPSBodG9iZTMyKExUVE5HX1ZJRVdFUl9TRUVLX0JFR0lOTklORyk7PGJy
Pg0KPGJyPg0KLcKgIMKgIMKgIMKgZG8gezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJl
dCA9IHNlbmQoY29udHJvbF9zb2NrLCAmYW1wO2NtZCwgc2l6ZW9mKGNtZCksIDApOzxicj4NCi3C
oCDCoCDCoCDCoH0gd2hpbGUgKHJldCAmbHQ7IDAgJmFtcDsmYW1wOyBlcnJubyA9PSBFSU5UUik7
PGJyPg0KLcKgIMKgIMKgIMKgaWYgKHJldCAmbHQ7IDApIHs8YnI+DQorwqAgwqAgwqAgwqByZXRf
bGVuID0gbHR0bmdfbGl2ZV9zZW5kKGNvbnRyb2xfc29jaywgJmFtcDtjbWQsIHNpemVvZihjbWQp
KTs8YnI+DQorwqAgwqAgwqAgwqBpZiAocmV0X2xlbiAmbHQ7IDApIHs8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7RXJyb3Igc2VuZGluZyBjbWRcbiZx
dW90Oyk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBlcnJvcjs8YnI+DQrCoCDC
oCDCoCDCoCB9PGJyPg0KLcKgIMKgIMKgIMKgZG8gezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHJldCA9IHNlbmQoY29udHJvbF9zb2NrLCAmYW1wO3JxLCBzaXplb2YocnEpLCAwKTs8YnI+
DQotwqAgwqAgwqAgwqB9IHdoaWxlIChyZXQgJmx0OyAwICZhbXA7JmFtcDsgZXJybm8gPT0gRUlO
VFIpOzxicj4NCi3CoCDCoCDCoCDCoGlmIChyZXQgJmx0OyAwKSB7PGJyPg0KK8KgIMKgIMKgIMKg
cmV0X2xlbiA9IGx0dG5nX2xpdmVfc2VuZChjb250cm9sX3NvY2ssICZhbXA7cnEsIHNpemVvZihy
cSkpOzxicj4NCivCoCDCoCDCoCDCoGlmIChyZXRfbGVuICZsdDsgMCkgezxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGZwcmludGYoc3RkZXJyLCAmcXVvdDtFcnJvciBzZW5kaW5nIGF0dGFj
aCByZXF1ZXN0XG4mcXVvdDspOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZXJy
b3I7PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCjxicj4NCi3CoCDCoCDCoCDCoGRvIHs8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSByZWN2KGNvbnRyb2xfc29jaywgJmFtcDtycCwg
c2l6ZW9mKHJwKSwgMCk7PGJyPg0KLcKgIMKgIMKgIMKgfSB3aGlsZSAocmV0ICZsdDsgMCAmYW1w
OyZhbXA7IGVycm5vID09IEVJTlRSKTs8YnI+DQotwqAgwqAgwqAgwqBpZiAocmV0ICZsdDsgMCkg
ezxicj4NCivCoCDCoCDCoCDCoHJldF9sZW4gPSBsdHRuZ19saXZlX3JlY3YoY29udHJvbF9zb2Nr
LCAmYW1wO3JwLCBzaXplb2YocnApKTs8YnI+DQorwqAgwqAgwqAgwqBpZiAocmV0X2xlbiA9PSAw
KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnByaW50ZihzdGRlcnIsICZxdW90O1tl
cnJvcl0gUmVtb3RlIHNpZGUgaGFzIGNsb3NlZCBjb25uZWN0aW9uXG4mcXVvdDspOzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJyb3I7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4N
CivCoCDCoCDCoCDCoGlmIChyZXRfbGVuICZsdDsgMCkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGZwcmludGYoc3RkZXJyLCAmcXVvdDtFcnJvciByZWNlaXZpbmcgYXR0YWNoIHJlc3Bv
bnNlXG4mcXVvdDspOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZXJyb3I7PGJy
Pg0KwqAgwqAgwqAgwqAgfTxicj4NCsKgIMKgIMKgIMKgIGlmIChiZTMydG9oKHJwLnN0YXR1cykg
IT0gTFRUTkdfVklFV0VSX0FUVEFDSF9PSykgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHJldCA9IC0xOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZW5kOzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJyb3I7PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4N
Cjxicj4NCsKgIMKgIMKgIMKgIHNlc3Npb24tJmd0O3N0cmVhbV9jb3VudCA9IGJlMzJ0b2gocnAu
c3RyZWFtc19jb3VudCk7PGJyPg0KwqAgwqAgwqAgwqAgc2Vzc2lvbi0mZ3Q7c3RyZWFtcyA9IHpt
YWxsb2Moc2Vzc2lvbi0mZ3Q7c3RyZWFtX2NvdW50ICo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBzaXplb2Yoc3RydWN0IHZpZXdlcl9zdHJlYW0pKTs8YnI+DQrCoCDC
oCDCoCDCoCBpZiAoIXNlc3Npb24tJmd0O3N0cmVhbXMpIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXQgPSAtMTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGVycm9y
Ozxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBmb3IgKGkgPSAwOyBp
ICZsdDsgYmUzMnRvaChycC5zdHJlYW1zX2NvdW50KTsgaSsrKSB7PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZG8gezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHJldCA9IHJlY3YoY29udHJvbF9zb2NrLCAmYW1wO3N0cmVhbSwgc2l6ZW9mKHN0cmVhbSksIDAp
Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0gd2hpbGUgKHJldCAmbHQ7IDAgJmFtcDsm
YW1wOyBlcnJubyA9PSBFSU5UUik7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJl
dCAmbHQ7IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXRfbGVuID0gbHR0bmdf
bGl2ZV9yZWN2KGNvbnRyb2xfc29jaywgJmFtcDtzdHJlYW0sIHNpemVvZihzdHJlYW0pKTs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocmV0X2xlbiA9PSAwKSB7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnByaW50ZihzdGRlcnIsICZxdW90O1tlcnJv
cl0gUmVtb3RlIHNpZGUgaGFzIGNsb3NlZCBjb25uZWN0aW9uXG4mcXVvdDspOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJyb3I7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXRfbGVu
ICZsdDsgMCkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZwcmlu
dGYoc3RkZXJyLCAmcXVvdDtFcnJvciByZWNlaXZpbmcgc3RyZWFtXG4mcXVvdDspOzxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZXJyb3I7PGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCkBAIC0zMzAsNyArMzUzLDYgQEAgaW50IGF0dGFjaF9z
ZXNzaW9uKGludCBpZCk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBNQVBfUFJJVkFURSB8IE1BUF9BTk9OWU1PVVMsIC0xLCAwKTs8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoc2Vzc2lvbi0mZ3Q7c3RyZWFtc1tpXS5tbWFwX2Jhc2Ug
PT0gTUFQX0ZBSUxFRCkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGZwcmludGYoc3RkZXJyLCAmcXVvdDttbWFwIGVycm9yXG4mcXVvdDspOzxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IC0xOzxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZXJyb3I7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgfTxicj4NCjxicj4NCkBAIC0zMzgsMTEgKzM2MCwxMCBAQCBpbnQgYXR0YWNoX3Nlc3Np
b24oaW50IGlkKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNlc3Np
b24tJmd0O3N0cmVhbXNbaV0ubWV0YWRhdGFfZmxhZyA9IDE7PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgfTxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQotwqAgwqAgwqAgwqByZXQgPSBzZXNz
aW9uLSZndDtzdHJlYW1fY291bnQ7PGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIHNlc3Npb24tJmd0
O3N0cmVhbV9jb3VudDs8YnI+DQo8YnI+DQotZW5kOjxicj4NCsKgZXJyb3I6PGJyPg0KLcKgIMKg
IMKgIMKgcmV0dXJuIHJldDs8YnI+DQorwqAgwqAgwqAgwqByZXR1cm4gLTE7PGJyPg0KwqB9PGJy
Pg0KPGJyPg0KwqBpbnQgZ2V0X21ldGFkYXRhKHZvaWQpPGJyPg0KQEAgLTM1MCw2ICszNzEsNyBA
QCBpbnQgZ2V0X21ldGFkYXRhKHZvaWQpPGJyPg0KwqAgwqAgwqAgwqAgc3RydWN0IGx0dG5nX3Zp
ZXdlcl9jbWQgY21kOzxicj4NCsKgIMKgIMKgIMKgIHN0cnVjdCBsdHRuZ192aWV3ZXJfZ2V0X21l
dGFkYXRhIHJxOzxicj4NCsKgIMKgIMKgIMKgIHN0cnVjdCBsdHRuZ192aWV3ZXJfbWV0YWRhdGFf
cGFja2V0IHJwOzxicj4NCivCoCDCoCDCoCDCoHNzaXplX3QgcmV0X2xlbjs8YnI+DQrCoCDCoCDC
oCDCoCBpbnQgcmV0Ozxicj4NCsKgIMKgIMKgIMKgIHVpbnQ2NF90IGk7PGJyPg0KwqAgwqAgwqAg
wqAgY2hhciAqZGF0YSA9IE5VTEw7PGJyPg0KQEAgLTM2OSwzMCArMzkxLDI3IEBAIGludCBnZXRf
bWV0YWRhdGEodm9pZCk8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBpZiAobWV0YWRhdGFfc3RyZWFt
X2lkICZsdDsgMCkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZwcmludGYoc3RkZXJy
LCAmcXVvdDtObyBtZXRhZGF0YSBzdHJlYW0gZm91bmRcbiZxdW90Oyk7PGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgcmV0ID0gLTE7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290
byBlcnJvcjs8YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgcnEuc3Ry
ZWFtX2lkID0gaHRvYmU2NChzZXNzaW9uLSZndDtzdHJlYW1zW21ldGFkYXRhX3N0cmVhbV9pZF0u
aWQpOzxicj4NCjxicj4NCi3CoCDCoCDCoCDCoGRvIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqByZXQgPSBzZW5kKGNvbnRyb2xfc29jaywgJmFtcDtjbWQsIHNpemVvZihjbWQpLCAwKTs8
YnI+DQotwqAgwqAgwqAgwqB9IHdoaWxlIChyZXQgJmx0OyAwICZhbXA7JmFtcDsgZXJybm8gPT0g
RUlOVFIpOzxicj4NCi3CoCDCoCDCoCDCoGlmIChyZXQgJmx0OyAwKSB7PGJyPg0KK8KgIMKgIMKg
IMKgcmV0X2xlbiA9IGx0dG5nX2xpdmVfc2VuZChjb250cm9sX3NvY2ssICZhbXA7Y21kLCBzaXpl
b2YoY21kKSk7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKHJldF9sZW4gJmx0OyAwKSB7PGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgZnByaW50ZihzdGRlcnIsICZxdW90O0Vycm9yIHNlbmRpbmcg
Y21kXG4mcXVvdDspOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZXJyb3I7PGJy
Pg0KwqAgwqAgwqAgwqAgfTxicj4NCi3CoCDCoCDCoCDCoGRvIHs8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXQgPSBzZW5kKGNvbnRyb2xfc29jaywgJmFtcDtycSwgc2l6ZW9mKHJxKSwg
MCk7PGJyPg0KLcKgIMKgIMKgIMKgfSB3aGlsZSAocmV0ICZsdDsgMCAmYW1wOyZhbXA7IGVycm5v
ID09IEVJTlRSKTs8YnI+DQotwqAgwqAgwqAgwqBpZiAocmV0ICZsdDsgMCkgezxicj4NCivCoCDC
oCDCoCDCoHJldF9sZW4gPSBsdHRuZ19saXZlX3NlbmQoY29udHJvbF9zb2NrLCAmYW1wO3JxLCBz
aXplb2YocnEpKTs8YnI+DQorwqAgwqAgwqAgwqBpZiAocmV0X2xlbiAmbHQ7IDApIHs8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7RXJyb3Igc2VuZGlu
ZyBnZXRfbWV0YWRhdGEgcmVxdWVzdFxuJnF1b3Q7KTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBnb3RvIGVycm9yOzxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQotwqAgwqAgwqAgwqBkbyB7
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gcmVjdihjb250cm9sX3NvY2ssICZh
bXA7cnAsIHNpemVvZihycCksIDApOzxicj4NCi3CoCDCoCDCoCDCoH0gd2hpbGUgKHJldCAmbHQ7
IDAgJmFtcDsmYW1wOyBlcnJubyA9PSBFSU5UUik7PGJyPg0KLcKgIMKgIMKgIMKgaWYgKHJldCAm
bHQ7IDApIHs8YnI+DQorwqAgwqAgwqAgwqByZXRfbGVuID0gbHR0bmdfbGl2ZV9yZWN2KGNvbnRy
b2xfc29jaywgJmFtcDtycCwgc2l6ZW9mKHJwKSk7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKHJldF9s
ZW4gPT0gMCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZwcmludGYoc3RkZXJyLCAm
cXVvdDtbZXJyb3JdIFJlbW90ZSBzaWRlIGhhcyBjbG9zZWQgY29ubmVjdGlvblxuJnF1b3Q7KTs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGVycm9yOzxicj4NCivCoCDCoCDCoCDC
oH08YnI+DQorwqAgwqAgwqAgwqBpZiAocmV0X2xlbiAmbHQ7IDApIHs8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7RXJyb3IgcmVjZWl2aW5nIG1ldGFk
YXRhIHJlc3BvbnNlXG4mcXVvdDspOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8g
ZXJyb3I7PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCkBAIC00MDEsMjEgKzQyMCwxOSBAQCBpbnQg
Z2V0X21ldGFkYXRhKHZvaWQpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgYnJlYWs7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2FzZSBMVFROR19WSUVXRVJf
Tk9fTkVXX01FVEFEQVRBOjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGZwcmludGYoc3RkZXJyLCAmcXVvdDtOTyBORVdcbiZxdW90Oyk7PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gLTE7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gMDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBnb3RvIGVuZDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjYXNlIExU
VE5HX1ZJRVdFUl9NRVRBREFUQV9FUlI6PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZnByaW50ZihzdGRlcnIsICZxdW90O0VSUlxuJnF1b3Q7KTs8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSAtMTs8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGVuZDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBnb3RvIGVycm9yOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGRlZmF1bHQ6PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnByaW50
ZihzdGRlcnIsICZxdW90O1VOS05PV05cbiZxdW90Oyk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gLTE7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZ290byBlbmQ7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZ290byBlcnJvcjs8YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0KPGJyPg0KwqAgwqAgwqAg
wqAgbGVuID0gYmU2NHRvaChycC5sZW4pOzxicj4NCsKgIMKgIMKgIMKgIGlmIChsZW4gJmx0Oz0g
MCkgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZW5kOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJyb3I7PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCjxicj4N
CsKgIMKgIMKgIMKgIGRhdGEgPSB6bWFsbG9jKGxlbik7PGJyPg0KQEAgLTQyMywyMCArNDQwLDI0
IEBAIGludCBnZXRfbWV0YWRhdGEodm9pZCk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQ
RVJST1IoJnF1b3Q7cmVsYXkgZGF0YSB6bWFsbG9jJnF1b3Q7KTs8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBnb3RvIGVycm9yOzxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQotwqAgwqAgwqAg
wqBkbyB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gcmVjdihjb250cm9sX3Nv
Y2ssIGRhdGEsIGxlbiwgTVNHX1dBSVRBTEwpOzxicj4NCi3CoCDCoCDCoCDCoH0gd2hpbGUgKHJl
dCAmbHQ7IDAgJmFtcDsmYW1wOyBlcnJubyA9PSBFSU5UUik7PGJyPg0KLcKgIMKgIMKgIMKgaWYg
KHJldCAmbHQ7IDApIHs8YnI+DQorwqAgwqAgwqAgwqByZXRfbGVuID0gbHR0bmdfbGl2ZV9yZWN2
KGNvbnRyb2xfc29jaywgZGF0YSwgbGVuKTs8YnI+DQorwqAgwqAgwqAgwqBpZiAocmV0X2xlbiA9
PSAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnByaW50ZihzdGRlcnIsICZxdW90
O1tlcnJvcl0gUmVtb3RlIHNpZGUgaGFzIGNsb3NlZCBjb25uZWN0aW9uXG4mcXVvdDspOzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJyb3JfZnJlZV9kYXRhOzxicj4NCivCoCDC
oCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqBpZiAocmV0X2xlbiAmbHQ7IDApIHs8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7RXJyb3IgcmVjZWl2aW5n
IHRyYWNlIHBhY2tldFxuJnF1b3Q7KTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcmVl
KGRhdGEpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJyb3I7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBlcnJvcl9mcmVlX2RhdGE7PGJyPg0KwqAgwqAgwqAg
wqAgfTxicj4NCsKgIMKgIMKgIMKgIGZyZWUoZGF0YSk7PGJyPg0KLTxicj4NCi3CoCDCoCDCoCDC
oHJldCA9IChpbnQpIGxlbjs8YnI+DQorwqAgwqAgwqAgwqByZXQgPSBsZW47PGJyPg0KwqBlbmQ6
PGJyPg0KLWVycm9yOjxicj4NCsKgIMKgIMKgIMKgIHJldHVybiByZXQ7PGJyPg0KKzxicj4NCitl
cnJvcl9mcmVlX2RhdGE6PGJyPg0KK8KgIMKgIMKgIMKgZnJlZShkYXRhKTs8YnI+DQorZXJyb3I6
PGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIC0xOzxicj4NCsKgfTxicj4NCjxicj4NCsKgaW50IGdl
dF9uZXh0X2luZGV4KHZvaWQpPGJyPg0KQEAgLTQ0NCw3ICs0NjUsNyBAQCBpbnQgZ2V0X25leHRf
aW5kZXgodm9pZCk8YnI+DQrCoCDCoCDCoCDCoCBzdHJ1Y3QgbHR0bmdfdmlld2VyX2NtZCBjbWQ7
PGJyPg0KwqAgwqAgwqAgwqAgc3RydWN0IGx0dG5nX3ZpZXdlcl9nZXRfbmV4dF9pbmRleCBycTs8
YnI+DQrCoCDCoCDCoCDCoCBzdHJ1Y3QgbHR0bmdfdmlld2VyX2luZGV4IHJwOzxicj4NCi3CoCDC
oCDCoCDCoGludCByZXQ7PGJyPg0KK8KgIMKgIMKgIMKgc3NpemVfdCByZXRfbGVuOzxicj4NCsKg
IMKgIMKgIMKgIGludCBpZDs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBjbWQuY21kID0gaHRvYmUz
MihMVFROR19WSUVXRVJfR0VUX05FWFRfSU5ERVgpOzxicj4NCkBAIC00NTUsMjcgKzQ3NiwyNiBA
QCBpbnQgZ2V0X25leHRfaW5kZXgodm9pZCk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBp
ZiAoc2Vzc2lvbi0mZ3Q7c3RyZWFtc1tpZF0ubWV0YWRhdGFfZmxhZykgezxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNvbnRpbnVlOzxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIH08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtZW1zZXQoJmFtcDtycSwg
MCwgc2l6ZW9mKHJxKSk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcnEuc3RyZWFtX2lk
ID0gaHRvYmU2NChzZXNzaW9uLSZndDtzdHJlYW1zW2lkXS5pZCk7PGJyPg0KPGJyPg0KwqByZXRy
eTo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkbyB7PGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gc2VuZChjb250cm9sX3NvY2ssICZhbXA7Y21kLCBz
aXplb2YoY21kKSwgMCk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfSB3aGlsZSAocmV0
ICZsdDsgMCAmYW1wOyZhbXA7IGVycm5vID09IEVJTlRSKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBpZiAocmV0ICZsdDsgMCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJl
dF9sZW4gPSBsdHRuZ19saXZlX3NlbmQoY29udHJvbF9zb2NrLCAmYW1wO2NtZCwgc2l6ZW9mKGNt
ZCkpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXRfbGVuICZsdDsgMCkgezxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZwcmludGYoc3RkZXJyLCAm
cXVvdDtFcnJvciBzZW5kaW5nIGNtZFxuJnF1b3Q7KTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBnb3RvIGVycm9yOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IH08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkbyB7PGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gc2VuZChjb250cm9sX3NvY2ssICZhbXA7cnEsIHNp
emVvZihycSksIDApOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0gd2hpbGUgKHJldCAm
bHQ7IDAgJmFtcDsmYW1wOyBlcnJubyA9PSBFSU5UUik7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgaWYgKHJldCAmbHQ7IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXRf
bGVuID0gbHR0bmdfbGl2ZV9zZW5kKGNvbnRyb2xfc29jaywgJmFtcDtycSwgc2l6ZW9mKHJxKSk7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJldF9sZW4gJmx0OyAwKSB7PGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnByaW50ZihzdGRlcnIsICZxdW90
O0Vycm9yIHNlbmRpbmcgZ2V0X25leHRfaW5kZXggcmVxdWVzdFxuJnF1b3Q7KTs8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGVycm9yOzxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIH08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkbyB7PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gcmVjdihjb250cm9sX3Nv
Y2ssICZhbXA7cnAsIHNpemVvZihycCksIDApOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oH0gd2hpbGUgKHJldCAmbHQ7IDAgJmFtcDsmYW1wOyBlcnJubyA9PSBFSU5UUik7PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJldCAmbHQ7IDApIHs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXRfbGVuID0gbHR0bmdfbGl2ZV9yZWN2KGNvbnRyb2xfc29jaywgJmFtcDty
cCwgc2l6ZW9mKHJwKSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJldF9sZW4g
PT0gMCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZwcmludGYo
c3RkZXJyLCAmcXVvdDtbZXJyb3JdIFJlbW90ZSBzaWRlIGhhcyBjbG9zZWQgY29ubmVjdGlvblxu
JnF1b3Q7KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGVy
cm9yOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBpZiAocmV0X2xlbiAmbHQ7IDApIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7RXJyb3IgcmVjZWl2aW5nIGluZGV4
IHJlc3BvbnNlXG4mcXVvdDspOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGdvdG8gZXJyb3I7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCkBAIC00
OTgsMTEgKzUxOCw5IEBAIHJldHJ5Ojxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGJyZWFrOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGNhc2UgTFRUTkdfVklFV0VSX0lOREVYX0VSUjo8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7
KEVSUilcbiZxdW90Oyk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmV0ID0gLTE7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgZ290byBlcnJvcjs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBkZWZhdWx0Ojxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGZwcmludGYoc3RkZXJyLCAmcXVvdDtTSE9VTEQgTk9UIEhBUFBF
TlxuJnF1b3Q7KTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXQgPSAtMTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBnb3RvIGVycm9yOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoIWZpcnN0X3BhY2tldF9zdHJlYW1faWQp
IHs8YnI+DQpAQCAtNTExLDEwICs1MjksMTAgQEAgcmV0cnk6PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgZmlyc3RfcGFja2V0X3N0cmVhbV9pZCA9IGlkOzxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0KLcKgIMKgIMKg
IMKgcmV0ID0gMDs8YnI+DQorwqAgwqAgwqAgwqByZXR1cm4gMDs8YnI+DQo8YnI+DQrCoGVycm9y
Ojxicj4NCi3CoCDCoCDCoCDCoHJldHVybiByZXQ7PGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIC0x
Ozxicj4NCsKgfTxicj4NCjxicj4NCsKgc3RhdGljPGJyPg0KQEAgLTUyNCwzNSArNTQyLDM0IEBA
IGludCBnZXRfZGF0YV9wYWNrZXQoaW50IGlkLCB1aW50NjRfdCBvZmZzZXQsPGJyPg0KwqAgwqAg
wqAgwqAgc3RydWN0IGx0dG5nX3ZpZXdlcl9jbWQgY21kOzxicj4NCsKgIMKgIMKgIMKgIHN0cnVj
dCBsdHRuZ192aWV3ZXJfZ2V0X3BhY2tldCBycTs8YnI+DQrCoCDCoCDCoCDCoCBzdHJ1Y3QgbHR0
bmdfdmlld2VyX3RyYWNlX3BhY2tldCBycDs8YnI+DQotwqAgwqAgwqAgwqBpbnQgcmV0Ozxicj4N
CivCoCDCoCDCoCDCoHNzaXplX3QgcmV0X2xlbjs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBjbWQu
Y21kID0gaHRvYmUzMihMVFROR19WSUVXRVJfR0VUX1BBQ0tFVCk7PGJyPg0KwqAgwqAgwqAgwqAg
Y21kLmRhdGFfc2l6ZSA9IHNpemVvZihycSk7PGJyPg0KwqAgwqAgwqAgwqAgY21kLmNtZF92ZXJz
aW9uID0gMDs8YnI+DQo8YnI+DQorwqAgwqAgwqAgwqBtZW1zZXQoJmFtcDtycSwgMCwgc2l6ZW9m
KHJxKSk7PGJyPg0KwqAgwqAgwqAgwqAgcnEuc3RyZWFtX2lkID0gaHRvYmU2NChzZXNzaW9uLSZn
dDtzdHJlYW1zW2lkXS5pZCk7PGJyPg0KwqAgwqAgwqAgwqAgLyogQWxyZWFkeSBpbiBiaWcgZW5k
aWFuLiAqLzxicj4NCsKgIMKgIMKgIMKgIHJxLm9mZnNldCA9IG9mZnNldDs8YnI+DQrCoCDCoCDC
oCDCoCBycS5sZW4gPSBodG9iZTMyKGxlbik7PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgZG8gezxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IHNlbmQoY29udHJvbF9zb2NrLCAmYW1w
O2NtZCwgc2l6ZW9mKGNtZCksIDApOzxicj4NCi3CoCDCoCDCoCDCoH0gd2hpbGUgKHJldCAmbHQ7
IDAgJmFtcDsmYW1wOyBlcnJubyA9PSBFSU5UUik7PGJyPg0KLcKgIMKgIMKgIMKgaWYgKHJldCAm
bHQ7IDApIHs8YnI+DQorwqAgwqAgwqAgwqByZXRfbGVuID0gbHR0bmdfbGl2ZV9zZW5kKGNvbnRy
b2xfc29jaywgJmFtcDtjbWQsIHNpemVvZihjbWQpKTs8YnI+DQorwqAgwqAgwqAgwqBpZiAocmV0
X2xlbiAmbHQ7IDApIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmcHJpbnRmKHN0ZGVy
ciwgJnF1b3Q7RXJyb3Igc2VuZGluZyBjbWRcbiZxdW90Oyk7PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZ290byBlcnJvcjs8YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0KLcKgIMKgIMKgIMKg
ZG8gezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IHNlbmQoY29udHJvbF9zb2Nr
LCAmYW1wO3JxLCBzaXplb2YocnEpLCAwKTs8YnI+DQotwqAgwqAgwqAgwqB9IHdoaWxlIChyZXQg
Jmx0OyAwICZhbXA7JmFtcDsgZXJybm8gPT0gRUlOVFIpOzxicj4NCi3CoCDCoCDCoCDCoGlmIChy
ZXQgJmx0OyAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgcmV0X2xlbiA9IGx0dG5nX2xpdmVfc2VuZChj
b250cm9sX3NvY2ssICZhbXA7cnEsIHNpemVvZihycSkpOzxicj4NCivCoCDCoCDCoCDCoGlmIChy
ZXRfbGVuICZsdDsgMCkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZwcmludGYoc3Rk
ZXJyLCAmcXVvdDtFcnJvciBzZW5kaW5nIGdldF9kYXRhX3BhY2tldCByZXF1ZXN0XG4mcXVvdDsp
Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZXJyb3I7PGJyPg0KwqAgwqAgwqAg
wqAgfTxicj4NCi3CoCDCoCDCoCDCoGRvIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXQgPSByZWN2KGNvbnRyb2xfc29jaywgJmFtcDtycCwgc2l6ZW9mKHJwKSwgMCk7PGJyPg0KLcKg
IMKgIMKgIMKgfSB3aGlsZSAocmV0ICZsdDsgMCAmYW1wOyZhbXA7IGVycm5vID09IEVJTlRSKTs8
YnI+DQotwqAgwqAgwqAgwqBpZiAocmV0ICZsdDsgMCkgezxicj4NCivCoCDCoCDCoCDCoHJldF9s
ZW4gPSBsdHRuZ19saXZlX3JlY3YoY29udHJvbF9zb2NrLCAmYW1wO3JwLCBzaXplb2YocnApKTs8
YnI+DQorwqAgwqAgwqAgwqBpZiAocmV0X2xlbiA9PSAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgZnByaW50ZihzdGRlcnIsICZxdW90O1tlcnJvcl0gUmVtb3RlIHNpZGUgaGFzIGNs
b3NlZCBjb25uZWN0aW9uXG4mcXVvdDspOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdv
dG8gZXJyb3I7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoGlmIChyZXRfbGVu
ICZsdDsgMCkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZwcmludGYoc3RkZXJyLCAm
cXVvdDtFcnJvciByZWNlaXZpbmcgZGF0YSByZXNwb25zZVxuJnF1b3Q7KTs8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBnb3RvIGVycm9yOzxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQpAQCAt
NTYwLDQ5ICs1NzcsNDUgQEAgaW50IGdldF9kYXRhX3BhY2tldChpbnQgaWQsIHVpbnQ2NF90IG9m
ZnNldCw8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBzd2l0Y2ggKGJlMzJ0b2gocnAuc3RhdHVzKSkg
ezxicj4NCsKgIMKgIMKgIMKgIGNhc2UgTFRUTkdfVklFV0VSX0dFVF9QQUNLRVRfT0s6PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbGVuID0gYmUzMnRvaChycC5sZW4pOzxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGJyZWFrOzxicj4NCsKgIMKgIMKgIMKgIGNhc2UgTFRUTkdfVklF
V0VSX0dFVF9QQUNLRVRfUkVUUlk6PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnByaW50
ZihzdGRlcnIsICZxdW90O1JFVFJZXG4mcXVvdDspOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHJldCA9IC0xOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZW5kOzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJyb3I7PGJyPg0KwqAgwqAgwqAgwqAgY2Fz
ZSBMVFROR19WSUVXRVJfR0VUX1BBQ0tFVF9FUlI6PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgaWYgKHJwLmZsYWdzICZhbXA7IExUVE5HX1ZJRVdFUl9GTEFHX05FV19NRVRBREFUQSkgezxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZwcmludGYoc3RkZXJyLCAm
cXVvdDtORVdfTUVUQURBVEFcbiZxdW90Oyk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmV0ID0gMDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBnb3RvIGVuZDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgZnByaW50ZihzdGRlcnIsICZxdW90O0VSUlxuJnF1b3Q7KTs8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSAtMTs8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBnb3RvIGVuZDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGVycm9y
Ozxicj4NCsKgIMKgIMKgIMKgIGRlZmF1bHQ6PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
ZnByaW50ZihzdGRlcnIsICZxdW90O1VOS05PV05cbiZxdW90Oyk7PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmV0ID0gLTE7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBl
bmQ7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBlcnJvcjs8YnI+DQrCoCDCoCDC
oCDCoCB9PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgbGVuID0gYmUzMnRvaChycC5sZW4pOzxicj4N
Ci3CoCDCoCDCoCDCoGlmIChsZW4gJmx0Oz0gMCkgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGdvdG8gZW5kOzxicj4NCivCoCDCoCDCoCDCoGlmIChsZW4gPT0gMCkgezxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJyb3I7PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCjxi
cj4NCsKgIMKgIMKgIMKgIGlmIChsZW4gJmd0OyBtbWFwX3NpemUpIHs8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7bW1hcF9zaXplIG5vdCBiaWcgZW5v
dWdoXG4mcXVvdDspOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IC0xOzxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZXJyb3I7PGJyPg0KwqAgwqAgwqAgwqAgfTxi
cj4NCjxicj4NCi3CoCDCoCDCoCDCoGRvIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXQgPSByZWN2KGNvbnRyb2xfc29jaywgc2Vzc2lvbi0mZ3Q7c3RyZWFtc1tpZF0ubW1hcF9iYXNl
LCBsZW4sIE1TR19XQUlUQUxMKTs8YnI+DQotwqAgwqAgwqAgwqB9IHdoaWxlIChyZXQgJmx0OyAw
ICZhbXA7JmFtcDsgZXJybm8gPT0gRUlOVFIpOzxicj4NCi3CoCDCoCDCoCDCoGlmIChyZXQgJmx0
OyAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgcmV0X2xlbiA9IGx0dG5nX2xpdmVfcmVjdihjb250cm9s
X3NvY2ssIHNlc3Npb24tJmd0O3N0cmVhbXNbaWRdLm1tYXBfYmFzZSwgbGVuKTs8YnI+DQorwqAg
wqAgwqAgwqBpZiAocmV0X2xlbiA9PSAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ZnByaW50ZihzdGRlcnIsICZxdW90O1tlcnJvcl0gUmVtb3RlIHNpZGUgaGFzIGNsb3NlZCBjb25u
ZWN0aW9uXG4mcXVvdDspOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJyb3I7
PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoGlmIChyZXRfbGVuICZsdDsgMCkg
ezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZwcmludGYoc3RkZXJyLCAmcXVvdDtFcnJv
ciByZWNlaXZpbmcgdHJhY2UgcGFja2V0XG4mcXVvdDspOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGdvdG8gZXJyb3I7PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCi3CoCDCoCDCoCDCoHJl
dCA9IGxlbjs8YnI+DQotPGJyPg0KwqBlbmQ6PGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIDA7PGJy
Pg0KwqBlcnJvcjo8YnI+DQotwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4NCivCoCDCoCDCoCDC
oHJldHVybiAtMTs8YnI+DQrCoH08YnI+DQo8YnI+DQrCoGludCBtYWluKGludCBhcmdjLCBjaGFy
ICoqYXJndik8YnI+DQpAQCAtNjM4LDcgKzY1MSw3IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFy
ICoqYXJndik8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCByZXQgPSBnZXRfZGF0YV9wYWNrZXQoZmly
c3RfcGFja2V0X3N0cmVhbV9pZCwgZmlyc3RfcGFja2V0X29mZnNldCw8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmaXJzdF9wYWNrZXRfbGVuKTs8YnI+DQotwqAgwqAg
wqAgwqBvayhyZXQgPT0gZmlyc3RfcGFja2V0X2xlbiw8YnI+DQorwqAgwqAgwqAgwqBvayhyZXQg
PT0gMCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDtHZXQg
b25lIGRhdGEgcGFja2V0IGZvciBzdHJlYW0gJWQsIG9mZnNldCAlZCwgbGVuICVkJnF1b3Q7LDxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZpcnN0X3BhY2tldF9zdHJl
YW1faWQsIGZpcnN0X3BhY2tldF9vZmZzZXQsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZmlyc3RfcGFja2V0X2xlbik7PGJyPg0KPHNwYW4gY2xhc3M9IkhPRW5aYiI+
PGZvbnQgY29sb3I9IiM4ODg4ODgiPi0tPGJyPg0KMi4xLjQ8YnI+DQo8YnI+DQo8L2ZvbnQ+PC9z
cGFuPjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PGJyIGNsZWFyPSJhbGwiPjxkaXY+PGJyPjwvZGl2
Pi0tIDxicj48ZGl2IGNsYXNzPSJnbWFpbF9zaWduYXR1cmUiPkrDqXLDqW1pZSBHYWxhcm5lYXU8
YnI+RWZmaWNpT1MgSW5jLjxicj48YSBocmVmPSJodHRwOi8vd3d3LmVmZmljaW9zLmNvbSIgdGFy
Z2V0PSJfYmxhbmsiPmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tPC9hPjwvZGl2Pg0KPC9kaXY+DQo=
--001a113923ea0684e70514e240d9--


--===============0446285436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0446285436==--
