From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH urcu 1/2] Fix: CDS_WFCQ_WOULDBLOCK
	typing for c++
Date: Tue, 8 Mar 2016 09:10:01 -0800
Message-ID: <20160308171001.GR3577__2087.68130182779$1457457140$gmane$org@linux.vnet.ibm.com>
References: <1457397224-10952-1-git-send-email-mathieu.desnoyers@efficios.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <paulmck@linux.vnet.ibm.com>) id 1adLA5-0001Ra-40
 for lttng-dev@lists.lttng.org; Tue, 08 Mar 2016 12:11:11 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
 Tue, 8 Mar 2016 10:10:02 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 27B5819D803E
 for <lttng-dev@lists.lttng.org>; Tue,  8 Mar 2016 09:57:51 -0700 (MST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u28H9tb928115052
 for <lttng-dev@lists.lttng.org>; Tue, 8 Mar 2016 17:09:55 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u28H9ssg006390
 for <lttng-dev@lists.lttng.org>; Tue, 8 Mar 2016 12:09:54 -0500
Content-Disposition: inline
In-Reply-To: <1457397224-10952-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu, Lai Jiangshan <jiangshanlai@gmail.com>
List-Id: lttng-dev@lists.lttng.org

On Mon, Mar 07, 2016 at 07:33:43PM -0500, Mathieu Desnoyers wrote:
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
>  urcu/wfcqueue.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/urcu/wfcqueue.h b/urcu/wfcqueue.h
> index 83ec219..c0bb289 100644
> --- a/urcu/wfcqueue.h
> +++ b/urcu/wfcqueue.h
> @@ -43,7 +43,7 @@ extern "C" {
>   * McKenney.
>   */
> 
> -#define CDS_WFCQ_WOULDBLOCK	((void *) -1UL)
> +#define CDS_WFCQ_WOULDBLOCK	((struct cds_wfcq_node *) -1UL)
> 
>  enum cds_wfcq_ret {
>  	CDS_WFCQ_RET_WOULDBLOCK =	-1,
> -- 
> 2.1.4
> 
