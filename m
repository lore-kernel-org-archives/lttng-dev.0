From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: UST check pointer/de-reference order
Date: Tue, 5 Jun 2012 11:19:05 -0400
Message-ID: <20120605151905.GB21325__240.044963038777$1338909570$gmane$org@Krystal>
References: <CABnnsm_MJHGq_TcjZj5_4_2TmTDhQUPGeJAyd3HYn6V7bPFQaw@mail.gmail.com>
	<524C960C5DFC794E82BE548D825F05CF283435F8@EU-MBX-01.mgc.mentorg.com>
	<CABnnsm8x2PJi93O=yu49-LZ8D2WMZwCr2PZQGb5zL97SeKQdxg@mail.gmail.com>
	<CABnnsm8mTJ4XGgV3XqJ-Qbp1QXOuGevrqL=7rgmPou-83pZ7tQ@mail.gmail.com>
	<524C960C5DFC794E82BE548D825F05CF28344927@EU-MBX-01.mgc.mentorg.com>
	<524C960C5DFC794E82BE548D825F05CF28344978@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SbvXH-0001R2-78
	for lttng-dev@lists.lttng.org; Tue, 05 Jun 2012 11:19:07 -0400
Content-Disposition: inline
In-Reply-To: <524C960C5DFC794E82BE548D825F05CF28344978@EU-MBX-01.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Oestman, Fredrik" <Fredrik_Oestman@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Oestman, Fredrik (Fredrik_Oestman@mentor.com) wrote:
> I stumbled across some code where pointers are de-referenced and then che=
cked for NULL.
> =

> Cheers,

merged into master and stable-2.0, thanks!

Mathieu

> =

> Fredrik =D6stman
> =

> =

> diff --git a/liblttng-ust-ctl/ustctl.c b/liblttng-ust-ctl/ustctl.c
> index 9789413..80aed04 100644
> --- a/liblttng-ust-ctl/ustctl.c
> +++ b/liblttng-ust-ctl/ustctl.c
> @@ -732,7 +732,7 @@ void ustctl_unmap_channel(struct lttng_ust_shm_handle=
 *handle)
>  struct lttng_ust_lib_ring_buffer *ustctl_open_stream_read(struct lttng_u=
st_shm_handle *handle,
>  	int cpu)
>  {
> -	struct channel *chan =3D handle->shadow_chan;
> +	struct channel *chan;
>  	int *shm_fd, *wait_fd;
>  	uint64_t *memory_map_size;
>  	struct lttng_ust_lib_ring_buffer *buf;
> @@ -741,6 +741,7 @@ struct lttng_ust_lib_ring_buffer *ustctl_open_stream_=
read(struct lttng_ust_shm_h
>  	if (!handle)
>  		return NULL;
>  =

> +	chan =3D handle->shadow_chan;
>  	buf =3D channel_get_ring_buffer(&chan->backend.config,
>  		chan, cpu, handle, &shm_fd, &wait_fd, &memory_map_size);
>  	if (!buf)
> @@ -784,11 +785,12 @@ int ustctl_get_mmap_len(struct lttng_ust_shm_handle=
 *handle,
>  		unsigned long *len)
>  {
>  	unsigned long mmap_buf_len;
> -	struct channel *chan =3D handle->shadow_chan;
> +	struct channel *chan;
>  =

>  	if (!handle || !buf || !len)
>  		return -EINVAL;
>  =

> +	chan =3D handle->shadow_chan;
>  	if (chan->backend.config.output !=3D RING_BUFFER_MMAP)
>  		return -EINVAL;
>  	mmap_buf_len =3D chan->backend.buf_size;
> @@ -805,11 +807,12 @@ int ustctl_get_max_subbuf_size(struct lttng_ust_shm=
_handle *handle,
>  		struct lttng_ust_lib_ring_buffer *buf,
>  		unsigned long *len)
>  {
> -	struct channel *chan =3D handle->shadow_chan;
> +	struct channel *chan;
>  =

>  	if (!handle || !buf || !len)
>  		return -EINVAL;
>  =

> +	chan =3D handle->shadow_chan;
>  	*len =3D chan->backend.subbuf_size;
>  	return 0;
>  }
> @@ -823,12 +826,13 @@ int ustctl_get_max_subbuf_size(struct lttng_ust_shm=
_handle *handle,
>  int ustctl_get_mmap_read_offset(struct lttng_ust_shm_handle *handle,
>  		struct lttng_ust_lib_ring_buffer *buf, unsigned long *off)
>  {
> -	struct channel *chan =3D handle->shadow_chan;
> +	struct channel *chan;
>  	unsigned long sb_bindex;
>  =

>  	if (!handle || !buf || !off)
>  		return -EINVAL;
>  =

> +	chan =3D handle->shadow_chan;
>  	if (chan->backend.config.output !=3D RING_BUFFER_MMAP)
>  		return -EINVAL;
>  	sb_bindex =3D subbuffer_id_get_index(&chan->backend.config,
> @@ -841,11 +845,12 @@ int ustctl_get_mmap_read_offset(struct lttng_ust_sh=
m_handle *handle,
>  int ustctl_get_subbuf_size(struct lttng_ust_shm_handle *handle,
>  		struct lttng_ust_lib_ring_buffer *buf, unsigned long *len)
>  {
> -	struct channel *chan =3D handle->shadow_chan;
> +	struct channel *chan;
>  =

>  	if (!handle || !buf || !len)
>  		return -EINVAL;
>  =

> +	chan =3D handle->shadow_chan;
>  	*len =3D lib_ring_buffer_get_read_data_size(&chan->backend.config, buf,
>  		handle);
>  	return 0;
> @@ -855,11 +860,12 @@ int ustctl_get_subbuf_size(struct lttng_ust_shm_han=
dle *handle,
>  int ustctl_get_padded_subbuf_size(struct lttng_ust_shm_handle *handle,
>  		struct lttng_ust_lib_ring_buffer *buf, unsigned long *len)
>  {
> -	struct channel *chan =3D handle->shadow_chan;
> +	struct channel *chan;
>  =

>  	if (!handle || !buf || !len)
>  		return -EINVAL;
>  =

> +	chan =3D handle->shadow_chan;
>  	*len =3D lib_ring_buffer_get_read_data_size(&chan->backend.config, buf,
>  		handle);
>  	*len =3D PAGE_ALIGN(*len);
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
