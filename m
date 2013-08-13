From: simon.marchi@polymtl.ca
Subject: [PATCH lttng-tools 4/5] Update bash completion
Date: Tue, 13 Aug 2013 16:26:24 -0400
Message-ID: <1376425585-31636-4-git-send-email-simon.marchi__20067.6564280458$1376425873$gmane$org@polymtl.ca>
References: <1376425585-31636-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [132.207.72.18] (helo=stationx.dorsal.polymtl.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simark@stationx.dorsal.polymtl.ca>)
	id 1V9L9e-0005hB-Cj
	for lttng-dev@lists.lttng.org; Tue, 13 Aug 2013 16:25:28 -0400
In-Reply-To: <1376425585-31636-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

From: Simon Marchi <simon.marchi@polymtl.ca>

- Refactor options completion to remove a little bit of code
  duplication.
- Add subcommand completion for the snapshot command. It is not perfect,
  but it's a start.
- Add some comments to functions here and there.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 extras/lttng-bash_completion |  173 ++++++++++++++++++++++++++----------------
 1 files changed, 106 insertions(+), 67 deletions(-)

diff --git a/extras/lttng-bash_completion b/extras/lttng-bash_completion
index d5a58f3..f5677e9 100644
--- a/extras/lttng-bash_completion
+++ b/extras/lttng-bash_completion
@@ -15,6 +15,7 @@
 # Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 #
 
+# Generates COMPREPLY with the existing session names
 _lttng_complete_sessions() {
 	# TODO
 	# This code does nothing for now. When there is a mecanism to get the
@@ -25,9 +26,18 @@ _lttng_complete_sessions() {
 	return
 }
 
+# Generates COMPREPLY with whatever is in the $options variable.
+_lttng_complete_options() {
+	COMPREPLY=( $(compgen -W "${options}" -- $cur) )
+}
+
+# Generates COMPREPLY with whatever is in the $commands variable.
+_lttng_complete_commands() {
+	COMPREPLY=( $(compgen -W "${commands}" -- $cur) )
+}
+
 _lttng_cmd_addcontext() {
-	local add_context_opts
-	add_context_opts=$(lttng add-context --list-options)
+	options=$(lttng add-context --list-options)
 
 	case $prev in
 	--session|-s)
@@ -44,26 +54,25 @@ _lttng_cmd_addcontext() {
 
 	case $cur in
 	-*)
-		COMPREPLY=( $(compgen -W "${add_context_opts}" -- $cur) )
+		_lttng_complete_options
 		return
 		;;
 	esac
 }
 
 _lttng_cmd_calibrate() {
-	local calibrate_opts
-	calibrate_opts=$(lttng calibrate --list-options)
+	options=$(lttng calibrate --list-options)
 
 	case $cur in
 	-*)
-		COMPREPLY=( $(compgen -W "${calibrate_opts}" -- $cur) )
+		_lttng_complete_options
+		return
 		;;
 	esac
 }
 
 _lttng_cmd_create() {
-	local create_opts
-	create_opts=$(lttng create --list-options)
+	options=$(lttng create --list-options)
 
 	case $prev in
 	--output|-o)
@@ -74,28 +83,28 @@ _lttng_cmd_create() {
 
 	case $cur in
 	-*)
-		COMPREPLY=( $(compgen -W "${create_opts}" -- $cur) )
+		_lttng_complete_options
 		return
 		;;
 	esac
 }
 
 _lttng_cmd_destroy() {
-	local destroy_opts
-	destroy_opts=$(lttng destroy --list-options)
+	options=$(lttng destroy --list-options)
 
 	case $cur in
 	-*)
-		COMPREPLY=( $(compgen -W "${destroy_opts}" -- $cur) )
+		_lttng_complete_options
+		return
 		;;
 	*)
 		_lttng_complete_sessions
+		return
 		;;
 	esac
 }
 _lttng_cmd_disablechannel() {
-	local disable_channel_opts
-	disable_channel_opts=$(lttng disable-channel --list-options)
+	options=$(lttng disable-channel --list-options)
 
 	case $prev in
 	--session|-s)
@@ -106,14 +115,13 @@ _lttng_cmd_disablechannel() {
 
 	case $cur in
 	-*)
-		COMPREPLY=( $(compgen -W "${disable_channel_opts}" -- $cur) )
+		_lttng_complete_options
 		return
 		;;
 	esac
 }
 _lttng_cmd_disableevent() {
-	local disable_event_opts
-	disable_event_opts=$(lttng disable-event --list-options)
+	options=$(lttng disable-event --list-options)
 
 	case $prev in
 	--session|-s)
@@ -127,15 +135,14 @@ _lttng_cmd_disableevent() {
 
 	case $cur in
 	-*)
-		COMPREPLY=( $(compgen -W "${disable_event_opts}" -- $cur) )
+		_lttng_complete_options
 		return
 		;;
 	esac
 }
 
 _lttng_cmd_enablechannel() {
-	local enable_channel_opts
-	enable_channel_opts=$(lttng enable-channel --list-options)
+	options=$(lttng enable-channel --list-options)
 
 	case $prev in
 	--session|-s)
@@ -146,15 +153,14 @@ _lttng_cmd_enablechannel() {
 
 	case $cur in
 	-*)
-		COMPREPLY=( $(compgen -W "${enable_channel_opts}" -- $cur) )
+		_lttng_complete_options
 		return
 		;;
 	esac
 }
 
 _lttng_cmd_enableevent() {
-	local enable_event_opts
-	enable_event_opts=$(lttng enable-event --list-options)
+	options=$(lttng enable-event --list-options)
 
 	case $prev in
 	--session|-s)
@@ -174,15 +180,14 @@ _lttng_cmd_enableevent() {
 
 	case $cur in
 	-*)
-		COMPREPLY=( $(compgen -W "${enable_event_opts}" -- $cur) )
+		_lttng_complete_options
 		return
 		;;
 	esac
 }
 
 _lttng_cmd_list() {
-	local list_opts
-	list_opts=$(lttng list --list-options)
+	options=$(lttng list --list-options)
 
 	case $prev in
 	--channel|-c)
@@ -192,7 +197,7 @@ _lttng_cmd_list() {
 
 	case $cur in
 	-*)
-		COMPREPLY=( $(compgen -W "${list_opts}" -- $cur) )
+		_lttng_complete_options
 		return
 		;;
 	*)
@@ -202,12 +207,11 @@ _lttng_cmd_list() {
 }
 
 _lttng_cmd_setsession() {
-	local set_session_opts
-	set_session_opts=$(lttng set-session --list-options)
+	options=$(lttng set-session --list-options)
 
 	case $cur in
 	-*)
-		COMPREPLY=( $(compgen -W "${set_session_opts}" -- $cur) )
+		_lttng_complete_options
 		return
 		;;
 	*)
@@ -217,27 +221,51 @@ _lttng_cmd_setsession() {
 	esac
 }
 
+_lttng_cmd_snapshot() {
+	options=$(lttng snapshot --list-options)
+	commands=$(lttng snapshot --list-commands)
+
+	_lttng_find_command $((command_found_index + 1))
+
+	if _lttng_cursor_is_after_command; then
+		case $prev in
+		--session|-s)
+			_lttng_complete_sessions
+			return
+			;;
+		esac
+
+		case $cur in
+		-*)
+			_lttng_complete_options
+			;;
+		esac
+	else
+		_lttng_complete_commands
+	fi
+}
+
 _lttng_cmd_start() {
-	local start_opts
-	start_opts=$(lttng start --list-options)
+	options=$(lttng start --list-options)
 
 	case $cur in
 	-*)
-		COMPREPLY=( $(compgen -W "${start_opts}" -- $cur) )
+		_lttng_complete_options
+		return
 		;;
 	*)
 		_lttng_complete_sessions
+		return
 		;;
 	esac
 }
 
 _lttng_cmd_stop() {
-	local stop_opts
-	stop_opts=$(lttng stop --list-options)
+	options=$(lttng stop --list-options)
 
 	case $cur in
 	-*)
-		COMPREPLY=( $(compgen -W "${stop_opts}" -- $cur) )
+		_lttng_complete_options
 		;;
 	*)
 		_lttng_complete_sessions
@@ -246,37 +274,26 @@ _lttng_cmd_stop() {
 }
 
 _lttng_cmd_version() {
-	local version_opts
-	version_opts=$(lttng version --list-options)
+	options=$(lttng version --list-options)
 
 	case $cur in
 	-*)
-		COMPREPLY=( $(compgen -W "${version_opts}" -- $cur) )
+		_lttng_complete_options
 		;;
 	esac
 }
 
 _lttng_cmd_view() {
-	local view_opts
-		view_opts=$(lttng view --list-options)
+	options=$(lttng view --list-options)
 
-		case $cur in
-		-*)
-		COMPREPLY=( $(compgen -W "${view_opts}" -- $cur) )
+	case $cur in
+	-*)
+		_lttng_complete_options
 		;;
 	esac
 }
 
-_lttng_opts() {
-	local opts
-	opts=$(lttng --list-options)
 
-	COMPREPLY=( $(compgen -W "${opts}" -- $cur) )
-}
-
-_lttng_commands() {
-	COMPREPLY=( $(compgen -W "$commands" -- $cur) )
-}
 
 _lttng_before_command() {
 	# Check if the previous word should alter the behavior
@@ -294,11 +311,11 @@ _lttng_before_command() {
 	case $cur in
 	-*)
 		# If the current word starts with a dash, complete with options
-		_lttng_opts
+		_lttng_complete_options
 		;;
 	*)
 		# Otherwise complete with commands
-		_lttng_commands
+		_lttng_complete_commands
 		;;
 	esac
 }
@@ -306,11 +323,13 @@ _lttng_before_command() {
 _lttng_after_command() {
 	local cmd_name
 
-	cmd_name=_lttng_cmd_${command//-/}
+	cmd_name=_lttng_cmd_${command_found//-/}
 
 	type -t $cmd_name | grep -q 'function' && $cmd_name
 }
 
+# Check if the word passed as the first parameter corresponds to a
+# command. $command must be set to the list of possible commands.
 _lttng_is_command() {
 	for command in $commands; do
 		if [ "$1" == "$command" ]; then
@@ -321,14 +340,18 @@ _lttng_is_command() {
 	return 1
 }
 
-_lttng() {
-	local cur prev commands command_found command_found_index
-
-	# Get the current and previous word
-	_get_comp_words_by_ref cur prev
-
-	# Get the valid LTTng commands
-	commands=$(lttng --list-commands)
+# Try to find a command in the current command line. Possible commands
+# are passed in $commands.
+#
+# This function takes an optional parameter that indicates the index
+# where to start the search in COMP_WORDS. If omitted, it defaults to 1.
+#
+# If a command is found, $command_found is filled with the name of the
+# command and $command_found_index is set to the index of the command in
+# $COMP_WORDS. If no command is found, $command_found is an empty string
+# and $command_found_index is set to -1.
+_lttng_find_command() {
+	start=${1:-1}
 
 	# The text of the found command
 	command_found=""
@@ -336,18 +359,34 @@ _lttng() {
 	# The index of the found command in COMP_WORDS
 	command_found_index=-1
 
-	for (( i = 1 ; i < ${#COMP_WORDS[@]} ; i++ )); do
+	for (( i = start ; i < ${#COMP_WORDS[@]} ; i++ )); do
 		_lttng_is_command ${COMP_WORDS[$i]}
 		if [ $? -eq 0 ]; then
 			command_found=${COMP_WORDS[$i]}
 			command_found_index=$i
 			break
 		fi
-
 	done
+}
+
+_lttng_cursor_is_after_command() {
+	[ -n "$command_found" ] && [ "$COMP_CWORD" -gt "$command_found_index" ]
+}
+
+_lttng() {
+	local cur prev commands command_found command_found_index
+
+	# Get the current and previous word
+	_get_comp_words_by_ref cur prev
+
+	# Get the valid first-level LTTng commands and options
+	commands=$(lttng --list-commands)
+	options=$(lttng --list-options)
+
+	_lttng_find_command
 
 	# Check if the cursor is before or after the command keyword
-	if [ -n "$command_found" ] && [ "$COMP_CWORD" -gt "$command_found_index" ]; then
+	if _lttng_cursor_is_after_command; then
 		_lttng_after_command
 	else
 		_lttng_before_command
-- 
1.7.1
