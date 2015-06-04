From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Subject: =?utf-8?q?lttng_list_-u_return_=22Error=3A_Command_er?=
	=?utf-8?q?ror=22?=
Date: Thu, 04 Jun 2015 11:00:42 +0800
Message-ID: <---.GY------rzHGY$b39120f9-2664-4e5c-bb89-379e7494cb0d__36508.9254956276$1433386922$gmane$org@aliyun.com>
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpcm9-301.freemail.mail.aliyun.com ([110.75.46.1])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <zhenyu.ren@aliyun.com>) id 1Z0LOo-00017A-RU
 for lttng-dev@lists.lttng.org; Wed, 03 Jun 2015 23:01:00 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,dev-team

   As the subject is my problem. It seems that the function get_cmdline_by_pid() will fail if kernel.pid_max > 100000 (i.e. 131072) 

static char *get_cmdline_by_pid(pid_t pid)
{
        int ret;
        FILE *fp = NULL;
        char *cmdline = NULL;
        char path[20];        /* Can't go bigger than /proc/65535/cmdline */


 I think path[20] is not big enough .Do you have any better idea?

Thanks
zhenyu.ren
