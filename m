From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Filter ABI changes to
	support	FILTER_BYTECODE_MAX_LEN (65536)
Date: Wed, 5 Sep 2012 10:44:43 -0400
Message-ID: <20120905144443.GA18761__14423.8589950421$1346856374$gmane$org@Krystal>
References: <1346799744-23032-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T9GqT-0002ky-2b
	for lttng-dev@lists.lttng.org; Wed, 05 Sep 2012 10:44:45 -0400
Content-Disposition: inline
In-Reply-To: <1346799744-23032-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Christian Babeux (christian.babeux@efficios.com) wrote:
> In order to support the filter bytecode maximum length (65536 bytes),
> the lttng_ust_filter_bytecode len field type must be able to
> hold more than a uint16_t. Change the field type to a uint32_t.
> 
> Also, since the relocation table is located at the end of the actual
> bytecode, the reloc_offset field must support offset values larger
> than 65535. Change the field type to a uint32_t. This change will
> allow support of relocation table appended to larger bytecode without
> breaking the ABI if the need arise in the future.
> 
> Both changes currently breaks the filter ABI, but this should be a
> reasonable compromise since the filtering feature has not been
> released yet.
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  include/lttng/ust-abi.h | 4 ++--
>  include/ust-comm.h      | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/lttng/ust-abi.h b/include/lttng/ust-abi.h
> index 0489e89..91639a7 100644
> --- a/include/lttng/ust-abi.h
> +++ b/include/lttng/ust-abi.h
> @@ -174,8 +174,8 @@ struct lttng_ust_calibrate {
>  
>  #define FILTER_BYTECODE_MAX_LEN		65536
>  struct lttng_ust_filter_bytecode {
> -	uint16_t len;
> -	uint16_t reloc_offset;
> +	uint32_t len;
> +	uint32_t reloc_offset;

You'll need to add a check in liblttng-ust/lttng-ust-comm.c, when the
data is received: we need to check that the reloc_offset is within the
data.

Mathieu

>  	char data[0];
>  };
>  
> diff --git a/include/ust-comm.h b/include/ust-comm.h
> index b09fcca..4a3e4ce 100644
> --- a/include/ust-comm.h
> +++ b/include/ust-comm.h
> @@ -132,8 +132,8 @@ struct ustcomm_ust_msg {
>  		struct lttng_ust_tracer_version version;
>  		struct lttng_ust_tracepoint_iter tracepoint;
>  		struct {
> -			uint16_t data_size;	/* following filter data */
> -			uint16_t reloc_offset;
> +			uint32_t data_size;	/* following filter data */
> +			uint32_t reloc_offset;
>  		} filter;
>  	} u;
>  };
> -- 
> 1.7.11.4
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
