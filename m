From: Jesper Derehag <jderehag@hotmail.com>
Subject: Re: clock_gettime vdso issue
Date: Thu, 26 Mar 2015 07:54:26 +0000
Message-ID: <DUB123-W38081C479AED1FCAFCDED3DD080__48624.1454178982$1427356545$gmane$org@phx.gbl>
References: <cf147ee4-5d02-423f-a352-672a739809d4@aliyun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from dub004-omc3s10.hotmail.com ([157.55.2.19])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jderehag@hotmail.com>) id 1Yb2ca-0002Nc-H3
 for lttng-dev@lists.lttng.org; Thu, 26 Mar 2015 03:54:37 -0400
In-Reply-To: <cf147ee4-5d02-423f-a352-672a739809d4@aliyun.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

There has been discussions regarding adding capability to override the clock implementation.

If that support is arriving, you could always write your own (say a separate thread reading clock periodically and storing in a cache, then your own clock implementation could get that cached timestamp).
Obviously you would need to think very carefully about clock resolution and frequency for your clock thread, but it should from a performance point of view be big improvement..

Maybe Mathieu(?) could shed some light on the clock override?

/Jesper

________________________________
> Date: Thu, 26 Mar 2015 15:25:49 +0800 
> From: zhenyu.ren@aliyun.com 
> To: lttng-dev@lists.lttng.org 
> Subject: [lttng-dev] clock_gettime vdso issue 
> 
> 
> Hi,Team 
> 
> You may not feel how painful I am with a too old GLIBC which does 
> NOT support vdso clock_gettime. Especially in ust case, 
> trace_clock_read will call clock_gettime to record the time of every 
> event. 
> Does anyone know how to avoid system_call clock_gettime with this old GLIBC?? 
> 
> Thanks in advance 
> zhenyu.ren 
> 
> 
> _______________________________________________ lttng-dev mailing list 
> lttng-dev@lists.lttng.org 
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev 
 		 	   		  
