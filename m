From: "Liu, Changcheng via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: get function names with lttng-ust-cyg-profile
Date: Tue, 23 Jun 2020 22:37:58 +0800
Message-ID: <20200623143758.GB4160129@jerryopenix>
Reply-To: "Liu, Changcheng" <changcheng.liu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.lttng.org (Postfix) with ESMTPS id 49rprg6tGmz13NB
 for <lttng-dev@lists.lttng.org>; Tue, 23 Jun 2020 10:41:55 -0400 (EDT)
Content-Disposition: inline
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: changcheng.liu@intel.com
List-Id: lttng-dev@lists.lttng.org

Hi all,
   I'm trying to use lttng-ust-cyg-profile to trace program.
   Does anyone know how to get function names and offset through lttng-ust-cyg-profile?

   In below example, the babeltrace could only get the function entry/exit value.
   1. Source program: instrument.c
         1 #include <stdio.h>
         2 
         3 int add3(int val) {
         4         return val + 3;
         5 }
         6 
         7 int main(int argc, char **argv) {
         8     int x = 4;
         9     
        10     puts("Press Enter to continue...");
        11     getchar();
        12     
        13     x = add3(x);
        14     
        15     return 0;
        16 }

   2. build source code:
        $ gcc -g -finstrument-functions instrument.c -o instrument

   3. run program:
       $ LD_PRELOAD=/usr/lib/x86_64-linux-gnu/liblttng-ust-cyg-profile.so ./instrument

   4. start trace process:
       trace@trace:~/cc$ sudo lttng create instrument
       Session instrument created.
       Traces will be output to /root/lttng-traces/instrument-20200623-222917

       trace@trace:~/cc$ sudo lttng enable-channel user_func_trace --userspace
       UST channel user_func_trace enabled for session instrument

       trace@trace:~/cc$ sudo lttng enable-event --userspace lttng_ust_cyg_profile:func_entry --channel user_func_trace
       UST event lttng_ust_cyg_profile:func_entry created in channel user_func_trace
       trace@trace:~/cc$ sudo lttng enable-event --userspace lttng_ust_cyg_profile:func_exit --channel user_func_trace
       UST event lttng_ust_cyg_profile:func_exit created in channel user_func_trace

       trace@trace:~/cc$ sudo lttng start
       Tracing started for session instrument

       trace@trace:~/cc$ sudo lttng destroy
       Destroying session instrument..
       Session instrument destroyed

       trace@trace:~/cc$ sudo babeltrace /root/lttng-traces/instrument-20200623-222917
       [22:29:55.388607059] (+?.?????????) trace lttng_ust_cyg_profile:func_entry: { cpu_id = 2 }, { addr = 0x5625C88B01A9, call_site = 0x5625C88B0237 }
       [22:29:55.388612293] (+0.000005234) trace lttng_ust_cyg_profile:func_exit: { cpu_id = 2 }, { addr = 0x5625C88B01A9, call_site = 0x5625C88B0237 }
       [22:29:55.388613215] (+0.000000922) trace lttng_ust_cyg_profile:func_exit: { cpu_id = 2 }, { addr = 0x5625C88B01EE, call_site = 0x7FE40BD5C0B3 }

B.R.
Changcheng
