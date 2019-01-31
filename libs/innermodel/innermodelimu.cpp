/*
 * Copyright 2016 <copyright holder> <email>
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * 
 */

#include "innermodelimu.h"

InnerModelIMU::InnerModelIMU(std::string id_, uint32_t _port, std::shared_ptr<InnerModelNode> parent_) : InnerModelNode(id_, parent_)
{
#if FCL_SUPPORT==1
	collisionObject = NULL;
#endif
	port = _port;
}

void InnerModelIMU::save(std::ofstream &out, int tabs)
{
	for (int i=0; i<tabs; i++) out << "\t";
	out << "<imu id=\"" << id.c_str() << "\" />\n";
}

void InnerModelIMU::print(bool verbose)
{
	if (verbose) printf("IMU.");
}

void InnerModelIMU::update()
{
	if (fixed)
	{
	}
	updateChildren();
}

std::shared_ptr<InnerModelNode> InnerModelIMU::copyNode(std::unordered_map<std::string, std::shared_ptr<InnerModelNode>> &hash, std::shared_ptr<InnerModelNode> parent)
{
	std::shared_ptr<InnerModelIMU> ret(new InnerModelIMU(id, port, parent));
	ret->level = level;
	ret->fixed = fixed;
	ret->children.clear();
	ret->attributes.clear();
	hash[id] = ret;
	ret->innerModel = parent->innerModel;

	for (auto iterator: children)
	{
		ret->addChild(iterator->copyNode(hash, ret));
	}

	return ret;
}
