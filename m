From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re:
 =?utf-8?b?5Zue5aSN77ya5Zue5aSN77yaIOWbnuWkje+8miBz?=
 =?utf-8?q?ome_tracepoints_not_exist_in_metadata=3F?=
Date: Thu, 2 Jul 2020 08:45:41 -0400
Message-ID: <20200702124541.GF4207@joraj-alpa>
References: <5efd3314-04ed-4868-a0c9-408434d330f4.zhenyu.ren@aliyun.com>
 <49dab706-ab7e-4156-9163-b8d9105b173d.zhenyu.ren@aliyun.com>
 <65af8a29-4fd7-454c-a060-8f06cb7bc931.zhenyu.ren@aliyun.com>
 <1653271969.18771.1593605240536.JavaMail.zimbra@efficios.com>
 <fb98f7b9-073e-4e02-86aa-03a0c4952c24.zhenyu.ren@aliyun.com>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49yHrS1Ks0z18gK
 for <lttng-dev@lists.lttng.org>; Thu,  2 Jul 2020 08:45:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <fb98f7b9-073e-4e02-86aa-03a0c4952c24.zhenyu.ren@aliyun.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, Jul 02, 2020 at 08:38:57AM +0800, zhenyu.ren via lttng-dev wrote:
> Thanks a lot. I will try single quotes but it may take hours get the result.
> Yesterday, I enabled the verbose option ,and found the following message "UST
> app reply event failed. Application died (in add_event_ust_registry() at
> ust-app.c:5405)" and "UST app notify socket unregister 34 (in
> ust_app_notify_sock_unregister() at ust-app.c:5562)". In fact ,the socket that
> Lttng-sessiond send reply to my app return an error with EPIPE. It seems that
> the pipe breaked.So do you have any hint for that?

From lttng master:
    ret = ustctl_reply_register_event(sock, event_id, ret_code);
    if (ret < 0) {
    	if (ret != -EPIPE && ret != -LTTNG_UST_ERR_EXITING) {
    		ERR("UST app reply event failed with ret %d", ret);
    	} else {
    		DBG3("UST app reply event failed. Application died");
    	}
    	/*
    	 * No need to wipe the create event since the application socket will
    	 * get close on error hence cleaning up everything by itself.
    	 */
    	goto error;
    }

EPIPE ifor this socket is considered as an expected scenario.

This normally indicates a short-lived application or that your application
crashed while lttng-ust and lttng-tools were performing an event registration.
Considering that the path leading to the ustctl_reply_register_event call is
preceded by a call fetching information from the same socket
(ustctl_recv_register_event), I expect this to be a completely normal scenario
unless you provide evidence that this application under tracing was acting
normally and had a long lifetime.

Cheers
