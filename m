From: David Goulet <dgoulet@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH] Rename LTTng index in CTF index
Date: Tue, 26 Nov 2013 11:36:20 -0500
Message-ID: <20131126163620.GB7267__5556.05633785508$1385483854$gmane$org@thessa>
References: <1385411558-18791-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1407545063=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VlLck-0006aQ-10
	for lttng-dev@lists.lttng.org; Tue, 26 Nov 2013 11:36:37 -0500
In-Reply-To: <1385411558-18791-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1407545063==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

David

On 25 Nov (15:32:38), Julien Desfossez wrote:
> Also the magic becomes a uint32_t instead of 6 chars for more aligned
> reads.
>=20
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  src/bin/lttng-relayd/index.h                 |  2 +-
>  src/bin/lttng-relayd/live.c                  | 12 +++---
>  src/bin/lttng-relayd/lttng-relayd.h          |  2 +-
>  src/common/consumer-stream.c                 |  6 +--
>  src/common/consumer-stream.h                 |  2 +-
>  src/common/consumer-timer.c                  |  2 +-
>  src/common/consumer.c                        |  4 +-
>  src/common/consumer.h                        |  6 +--
>  src/common/index/Makefile.am                 |  2 +-
>  src/common/index/ctf-index.h                 | 60 ++++++++++++++++++++++=
++++++
>  src/common/index/index.c                     | 11 ++---
>  src/common/index/index.h                     |  4 +-
>  src/common/index/lttng-index.h               | 58 ----------------------=
-----
>  src/common/kernel-consumer/kernel-consumer.c |  4 +-
>  src/common/relayd/relayd.c                   |  4 +-
>  src/common/relayd/relayd.h                   |  2 +-
>  src/common/sessiond-comm/relayd.h            |  2 +-
>  src/common/ust-consumer/ust-consumer.c       |  4 +-
>  tests/regression/tools/live/live_test.c      |  2 +-
>  19 files changed, 96 insertions(+), 93 deletions(-)
>  create mode 100644 src/common/index/ctf-index.h
>  delete mode 100644 src/common/index/lttng-index.h
>=20
> diff --git a/src/bin/lttng-relayd/index.h b/src/bin/lttng-relayd/index.h
> index 3ca7263..9a10cea 100644
> --- a/src/bin/lttng-relayd/index.h
> +++ b/src/bin/lttng-relayd/index.h
> @@ -36,7 +36,7 @@ struct relay_index {
>  	int to_close_fd;
> =20
>  	/* Index packet data. This is the data that is written on disk. */
> -	struct lttng_packet_index index_data;
> +	struct ctf_packet_index index_data;
> =20
>  	/* key1 =3D stream_id, key2 =3D net_seq_num */
>  	struct lttng_ht_two_u64 key;
> diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
> index 851be9f..cdbb5b1 100644
> --- a/src/bin/lttng-relayd/live.c
> +++ b/src/bin/lttng-relayd/live.c
> @@ -614,7 +614,7 @@ static int open_index(struct relay_viewer_stream *str=
eam)
>  {
>  	int ret;
>  	char fullpath[PATH_MAX];
> -	struct lttng_packet_index_file_hdr hdr;
> +	struct ctf_packet_index_file_hdr hdr;
> =20
>  	if (stream->tracefile_count > 0) {
>  		ret =3D snprintf(fullpath, sizeof(fullpath), "%s/" DEFAULT_INDEX_DIR "=
/%s_%"
> @@ -649,13 +649,13 @@ static int open_index(struct relay_viewer_stream *s=
tream)
>  		PERROR("Reading index header");
>  		goto error;
>  	}
> -	if (strncmp(hdr.magic, INDEX_MAGIC, sizeof(hdr.magic)) !=3D 0) {
> +	if (be32toh(hdr.magic) !=3D CTF_INDEX_MAGIC) {
>  		ERR("Invalid header magic");
>  		ret =3D -1;
>  		goto error;
>  	}
> -	if (be32toh(hdr.index_major) !=3D INDEX_MAJOR ||
> -			be32toh(hdr.index_minor) !=3D INDEX_MINOR) {
> +	if (be32toh(hdr.index_major) !=3D CTF_INDEX_MAJOR ||
> +			be32toh(hdr.index_minor) !=3D CTF_INDEX_MINOR) {
>  		ERR("Invalid header version");
>  		ret =3D -1;
>  		goto error;
> @@ -747,7 +747,7 @@ int init_viewer_stream(struct relay_stream *stream, i=
nt seek_last)
>  	if (seek_last && viewer_stream->index_read_fd > 0) {
>  		ret =3D lseek(viewer_stream->index_read_fd,
>  				viewer_stream->total_index_received *
> -					sizeof(struct lttng_packet_index),
> +					sizeof(struct ctf_packet_index),
>  				SEEK_CUR);
>  		if (ret < 0) {
>  			goto error;
> @@ -1075,7 +1075,7 @@ int viewer_get_next_index(struct relay_command *cmd,
>  	int ret;
>  	struct lttng_viewer_get_next_index request_index;
>  	struct lttng_viewer_index viewer_index;
> -	struct lttng_packet_index packet_index;
> +	struct ctf_packet_index packet_index;
>  	struct relay_viewer_stream *vstream;
>  	struct relay_stream *rstream;
> =20
> diff --git a/src/bin/lttng-relayd/lttng-relayd.h b/src/bin/lttng-relayd/l=
ttng-relayd.h
> index f22b115..6840aba 100644
> --- a/src/bin/lttng-relayd/lttng-relayd.h
> +++ b/src/bin/lttng-relayd/lttng-relayd.h
> @@ -25,7 +25,7 @@
>  #include <urcu/wfqueue.h>
> =20
>  #include <common/hashtable/hashtable.h>
> -#include <common/index/lttng-index.h>
> +#include <common/index/ctf-index.h>
> =20
>  #include "ctf-trace.h"
> =20
> diff --git a/src/common/consumer-stream.c b/src/common/consumer-stream.c
> index 063ba50..422dd0d 100644
> --- a/src/common/consumer-stream.c
> +++ b/src/common/consumer-stream.c
> @@ -331,7 +331,7 @@ void consumer_stream_destroy(struct lttng_consumer_st=
ream *stream,
>   * Return 0 on success or else a negative value.
>   */
>  int consumer_stream_write_index(struct lttng_consumer_stream *stream,
> -		struct lttng_packet_index *index)
> +		struct ctf_packet_index *index)
>  {
>  	int ret;
>  	struct consumer_relayd_sock_pair *relayd;
> @@ -348,8 +348,8 @@ int consumer_stream_write_index(struct lttng_consumer=
_stream *stream,
>  		ssize_t size_ret;
> =20
>  		size_ret =3D index_write(stream->index_fd, index,
> -				sizeof(struct lttng_packet_index));
> -		if (size_ret < sizeof(struct lttng_packet_index)) {
> +				sizeof(struct ctf_packet_index));
> +		if (size_ret < sizeof(struct ctf_packet_index)) {
>  			ret =3D -1;
>  		} else {
>  			ret =3D 0;
> diff --git a/src/common/consumer-stream.h b/src/common/consumer-stream.h
> index 79efa72..c5fb097 100644
> --- a/src/common/consumer-stream.h
> +++ b/src/common/consumer-stream.h
> @@ -72,7 +72,7 @@ void consumer_stream_destroy_buffers(struct lttng_consu=
mer_stream *stream);
>   * Write index of a specific stream either on the relayd or local disk.
>   */
>  int consumer_stream_write_index(struct lttng_consumer_stream *stream,
> -		struct lttng_packet_index *index);
> +		struct ctf_packet_index *index);
> =20
>  int consumer_stream_sync_metadata(struct lttng_consumer_local_data *ctx,
>  		uint64_t session_id);
> diff --git a/src/common/consumer-timer.c b/src/common/consumer-timer.c
> index b97cb28..b681ae7 100644
> --- a/src/common/consumer-timer.c
> +++ b/src/common/consumer-timer.c
> @@ -115,7 +115,7 @@ static void metadata_switch_timer(struct lttng_consum=
er_local_data *ctx,
>  static int send_empty_index(struct lttng_consumer_stream *stream, uint64=
_t ts)
>  {
>  	int ret;
> -	struct lttng_packet_index index;
> +	struct ctf_packet_index index;
> =20
>  	memset(&index, 0, sizeof(index));
>  	index.timestamp_end =3D htobe64(ts);
> diff --git a/src/common/consumer.c b/src/common/consumer.c
> index 8aa8903..4be5ce6 100644
> --- a/src/common/consumer.c
> +++ b/src/common/consumer.c
> @@ -1341,7 +1341,7 @@ ssize_t lttng_consumer_on_read_subbuffer_mmap(
>  		struct lttng_consumer_local_data *ctx,
>  		struct lttng_consumer_stream *stream, unsigned long len,
>  		unsigned long padding,
> -		struct lttng_packet_index *index)
> +		struct ctf_packet_index *index)
>  {
>  	unsigned long mmap_offset;
>  	void *mmap_base;
> @@ -1549,7 +1549,7 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
>  		struct lttng_consumer_local_data *ctx,
>  		struct lttng_consumer_stream *stream, unsigned long len,
>  		unsigned long padding,
> -		struct lttng_packet_index *index)
> +		struct ctf_packet_index *index)
>  {
>  	ssize_t ret =3D 0, written =3D 0, ret_splice =3D 0;
>  	loff_t offset =3D 0;
> diff --git a/src/common/consumer.h b/src/common/consumer.h
> index aef7f56..c206970 100644
> --- a/src/common/consumer.h
> +++ b/src/common/consumer.h
> @@ -32,7 +32,7 @@
>  #include <common/compat/uuid.h>
>  #include <common/sessiond-comm/sessiond-comm.h>
>  #include <common/pipe.h>
> -#include <common/index/lttng-index.h>
> +#include <common/index/ctf-index.h>
> =20
>  /* Commands for consumer */
>  enum lttng_consumer_command {
> @@ -611,12 +611,12 @@ ssize_t lttng_consumer_on_read_subbuffer_mmap(
>  		struct lttng_consumer_local_data *ctx,
>  		struct lttng_consumer_stream *stream, unsigned long len,
>  		unsigned long padding,
> -		struct lttng_packet_index *index);
> +		struct ctf_packet_index *index);
>  ssize_t lttng_consumer_on_read_subbuffer_splice(
>  		struct lttng_consumer_local_data *ctx,
>  		struct lttng_consumer_stream *stream, unsigned long len,
>  		unsigned long padding,
> -		struct lttng_packet_index *index);
> +		struct ctf_packet_index *index);
>  int lttng_consumer_take_snapshot(struct lttng_consumer_stream *stream);
>  int lttng_consumer_get_produced_snapshot(struct lttng_consumer_stream *s=
tream,
>  		unsigned long *pos);
> diff --git a/src/common/index/Makefile.am b/src/common/index/Makefile.am
> index 104d99c..054b0aa 100644
> --- a/src/common/index/Makefile.am
> +++ b/src/common/index/Makefile.am
> @@ -2,4 +2,4 @@ AM_CPPFLAGS =3D -I$(top_srcdir)/include -I$(top_srcdir)/s=
rc
> =20
>  noinst_LTLIBRARIES =3D libindex.la
> =20
> -libindex_la_SOURCES =3D index.c index.h lttng-index.h
> +libindex_la_SOURCES =3D index.c index.h ctf-index.h
> diff --git a/src/common/index/ctf-index.h b/src/common/index/ctf-index.h
> new file mode 100644
> index 0000000..0efa888
> --- /dev/null
> +++ b/src/common/index/ctf-index.h
> @@ -0,0 +1,60 @@
> +/*
> + * Copyright (C) 2013 - Julien Desfossez <jdesfossez@efficios.com>
> + *                      Mathieu Desnoyers <mathieu.desnoyers@efficios.co=
m>
> + *                      David Goulet <dgoulet@efficios.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN THE
> + * SOFTWARE.
> + */
> +
> +#ifndef LTTNG_INDEX_H
> +#define LTTNG_INDEX_H
> +
> +#include <limits.h>
> +
> +#define CTF_INDEX_MAGIC 0xC1F1DCC1
> +#define CTF_INDEX_MAJOR 1
> +#define CTF_INDEX_MINOR 0
> +
> +/*
> + * Header at the beginning of each index file.
> + * All integer fields are stored in big endian.
> + */
> +struct ctf_packet_index_file_hdr {
> +	uint32_t magic;
> +	uint32_t index_major;
> +	uint32_t index_minor;
> +	/* struct packet_index_len, in bytes */
> +	uint32_t packet_index_len;
> +} __attribute__((__packed__));
> +
> +/*
> + * Packet index generated for each trace packet store in a trace file.
> + * All integer fields are stored in big endian.
> + */
> +struct ctf_packet_index {
> +	uint64_t offset;		/* offset of the packet in the file, in bytes */
> +	uint64_t packet_size;		/* packet size, in bits */
> +	uint64_t content_size;		/* content size, in bits */
> +	uint64_t timestamp_begin;
> +	uint64_t timestamp_end;
> +	uint64_t events_discarded;
> +	uint64_t stream_id;
> +} __attribute__((__packed__));
> +
> +#endif /* LTTNG_INDEX_H */
> diff --git a/src/common/index/index.c b/src/common/index/index.c
> index cddc58c..2946f7b 100644
> --- a/src/common/index/index.c
> +++ b/src/common/index/index.c
> @@ -36,7 +36,7 @@ int index_create_file(char *path_name, char *stream_nam=
e, int uid, int gid,
>  {
>  	int ret, fd =3D -1;
>  	ssize_t size_ret;
> -	struct lttng_packet_index_file_hdr hdr;
> +	struct ctf_packet_index_file_hdr hdr;
>  	char fullpath[PATH_MAX];
> =20
>  	ret =3D snprintf(fullpath, sizeof(fullpath), "%s/" DEFAULT_INDEX_DIR,
> @@ -62,9 +62,10 @@ int index_create_file(char *path_name, char *stream_na=
me, int uid, int gid,
>  	}
>  	fd =3D ret;
> =20
> -	memcpy(hdr.magic, INDEX_MAGIC, sizeof(hdr.magic));
> -	hdr.index_major =3D htobe32(INDEX_MAJOR);
> -	hdr.index_minor =3D htobe32(INDEX_MINOR);
> +	hdr.magic =3D htobe32(CTF_INDEX_MAGIC);
> +	hdr.index_major =3D htobe32(CTF_INDEX_MAJOR);
> +	hdr.index_minor =3D htobe32(CTF_INDEX_MINOR);
> +	hdr.packet_index_len =3D sizeof(struct ctf_packet_index);
> =20
>  	size_ret =3D lttng_write(fd, &hdr, sizeof(hdr));
>  	if (size_ret < sizeof(hdr)) {
> @@ -93,7 +94,7 @@ error:
>   * Return "len" on success or else < len on error. errno contains error
>   * details.
>   */
> -ssize_t index_write(int fd, struct lttng_packet_index *index, size_t len)
> +ssize_t index_write(int fd, struct ctf_packet_index *index, size_t len)
>  {
>  	ssize_t ret;
> =20
> diff --git a/src/common/index/index.h b/src/common/index/index.h
> index 4ffc526..744fe01 100644
> --- a/src/common/index/index.h
> +++ b/src/common/index/index.h
> @@ -21,10 +21,10 @@
> =20
>  #include <inttypes.h>
> =20
> -#include "lttng-index.h"
> +#include "ctf-index.h"
> =20
>  int index_create_file(char *path_name, char *stream_name, int uid, int g=
id,
>  		uint64_t size, uint64_t count);
> -ssize_t index_write(int fd, struct lttng_packet_index *index, size_t len=
);
> +ssize_t index_write(int fd, struct ctf_packet_index *index, size_t len);
> =20
>  #endif /* _INDEX_H */
> diff --git a/src/common/index/lttng-index.h b/src/common/index/lttng-inde=
x.h
> deleted file mode 100644
> index 4327cbd..0000000
> --- a/src/common/index/lttng-index.h
> +++ /dev/null
> @@ -1,58 +0,0 @@
> -/*
> - * Copyright (C) 2013 - Julien Desfossez <jdesfossez@efficios.com>
> - *                      Mathieu Desnoyers <mathieu.desnoyers@efficios.co=
m>
> - *                      David Goulet <dgoulet@efficios.com>
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> - * of this software and associated documentation files (the "Software"),=
 to deal
> - * in the Software without restriction, including without limitation the=
 rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL THE
> - * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN THE
> - * SOFTWARE.
> - */
> -
> -#ifndef LTTNG_INDEX_H
> -#define LTTNG_INDEX_H
> -
> -#include <limits.h>
> -
> -#define INDEX_MAGIC "CTFIDX"
> -#define INDEX_MAJOR 1
> -#define INDEX_MINOR 0
> -
> -/*
> - * Header at the beginning of each index file.
> - * All integer fields are stored in big endian.
> - */
> -struct lttng_packet_index_file_hdr {
> -	char magic[6];
> -	uint32_t index_major;
> -	uint32_t index_minor;
> -} __attribute__((__packed__));
> -
> -/*
> - * Packet index generated for each trace packet store in a trace file.
> - * All integer fields are stored in big endian.
> - */
> -struct lttng_packet_index {
> -	uint64_t offset;		/* offset of the packet in the file, in bytes */
> -	uint64_t packet_size;		/* packet size, in bits */
> -	uint64_t content_size;		/* content size, in bits */
> -	uint64_t timestamp_begin;
> -	uint64_t timestamp_end;
> -	uint64_t events_discarded;
> -	uint64_t stream_id;
> -} __attribute__((__packed__));
> -
> -#endif /* LTTNG_INDEX_H */
> diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/ke=
rnel-consumer/kernel-consumer.c
> index 44d58d9..88499b2 100644
> --- a/src/common/kernel-consumer/kernel-consumer.c
> +++ b/src/common/kernel-consumer/kernel-consumer.c
> @@ -911,7 +911,7 @@ error_fatal:
>   *
>   * Return 0 on success or else a negative value.
>   */
> -static int get_index_values(struct lttng_packet_index *index, int infd)
> +static int get_index_values(struct ctf_packet_index *index, int infd)
>  {
>  	int ret;
> =20
> @@ -1007,7 +1007,7 @@ ssize_t lttng_kconsumer_read_subbuffer(struct lttng=
_consumer_stream *stream,
>  	int err, write_index =3D 1;
>  	ssize_t ret =3D 0;
>  	int infd =3D stream->wait_fd;
> -	struct lttng_packet_index index;
> +	struct ctf_packet_index index;
> =20
>  	DBG("In read_subbuffer (infd : %d)", infd);
> =20
> diff --git a/src/common/relayd/relayd.c b/src/common/relayd/relayd.c
> index 7c90b4d..ca2666c 100644
> --- a/src/common/relayd/relayd.c
> +++ b/src/common/relayd/relayd.c
> @@ -26,7 +26,7 @@
>  #include <common/common.h>
>  #include <common/defaults.h>
>  #include <common/sessiond-comm/relayd.h>
> -#include <common/index/lttng-index.h>
> +#include <common/index/ctf-index.h>
> =20
>  #include "relayd.h"
> =20
> @@ -734,7 +734,7 @@ error:
>   * Send index to the relayd.
>   */
>  int relayd_send_index(struct lttcomm_relayd_sock *rsock,
> -		struct lttng_packet_index *index, uint64_t relay_stream_id,
> +		struct ctf_packet_index *index, uint64_t relay_stream_id,
>  		uint64_t net_seq_num)
>  {
>  	int ret;
> diff --git a/src/common/relayd/relayd.h b/src/common/relayd/relayd.h
> index d12d7a4..e61b2ff 100644
> --- a/src/common/relayd/relayd.h
> +++ b/src/common/relayd/relayd.h
> @@ -46,7 +46,7 @@ int relayd_begin_data_pending(struct lttcomm_relayd_soc=
k *sock, uint64_t id);
>  int relayd_end_data_pending(struct lttcomm_relayd_sock *sock, uint64_t i=
d,
>  		unsigned int *is_data_inflight);
>  int relayd_send_index(struct lttcomm_relayd_sock *rsock,
> -		struct lttng_packet_index *index, uint64_t relay_stream_id,
> +		struct ctf_packet_index *index, uint64_t relay_stream_id,
>  		uint64_t net_seq_num);
> =20
>  #endif /* _RELAYD_H */
> diff --git a/src/common/sessiond-comm/relayd.h b/src/common/sessiond-comm=
/relayd.h
> index 24c4c6e..ff56d3a 100644
> --- a/src/common/sessiond-comm/relayd.h
> +++ b/src/common/sessiond-comm/relayd.h
> @@ -26,7 +26,7 @@
> =20
>  #include <lttng/lttng.h>
>  #include <common/defaults.h>
> -#include <common/index/lttng-index.h>
> +#include <common/index/ctf-index.h>
>  #include <config.h>
> =20
>  #define RELAYD_VERSION_COMM_MAJOR             VERSION_MAJOR
> diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-cons=
umer/ust-consumer.c
> index c6bd519..b7c15a1 100644
> --- a/src/common/ust-consumer/ust-consumer.c
> +++ b/src/common/ust-consumer/ust-consumer.c
> @@ -1704,7 +1704,7 @@ void lttng_ustconsumer_del_stream(struct lttng_cons=
umer_stream *stream)
>   *
>   * Return 0 on success or else a negative value.
>   */
> -static int get_index_values(struct lttng_packet_index *index,
> +static int get_index_values(struct ctf_packet_index *index,
>  		struct ustctl_consumer_stream *ustream)
>  {
>  	int ret;
> @@ -1869,7 +1869,7 @@ int lttng_ustconsumer_read_subbuffer(struct lttng_c=
onsumer_stream *stream,
>  	long ret =3D 0;
>  	char dummy;
>  	struct ustctl_consumer_stream *ustream;
> -	struct lttng_packet_index index;
> +	struct ctf_packet_index index;
> =20
>  	assert(stream);
>  	assert(stream->ustream);
> diff --git a/tests/regression/tools/live/live_test.c b/tests/regression/t=
ools/live/live_test.c
> index 2482e50..75d4e4f 100644
> --- a/tests/regression/tools/live/live_test.c
> +++ b/tests/regression/tools/live/live_test.c
> @@ -41,7 +41,7 @@
>  #include <common/common.h>
> =20
>  #include <bin/lttng-relayd/lttng-viewer.h>
> -#include <common/index/lttng-index.h>
> +#include <common/index/ctf-index.h>
> =20
>  #define SESSION1 "test1"
>  #define RELAYD_URL "net://localhost"
> --=20
> 1.8.3.2
>=20

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSlM4EXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02eHsH/j8ThuXbW8KYdOVqYLo0SEmV
pf7Tq85T2LbYZv+6ltBLQofpDDvo3633rXPDMI/J2IvuiQ6BodwghA0KFm/RJLlU
wZJmDbC4ea7S+2f9xGeLflzNp+EzdMG6LkDnzzIk9a0Ob58W4UIbajdJHroFJELv
SrpN47aaBWsRVzdj7IpvOnQaPL/K2STQXTqyjYoeDvMV+YcOKZgyVa+opfS4JaHz
F1weGM2DIAnIExVtaD2In8Xu4AhhLv4lIedXOJ+LIQzrHIdN+yPkXXdUEl0tJ533
Pga3jHLYBSz/0aDdWmS9utybUtSeHcIIKm+AdOrb2el+D6Mq7o229Gjr/3TNw4A=
=lgrH
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--


--===============1407545063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1407545063==--
