<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2020-2023, Goldorion, opensource contributors
 #
 # Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
 # it under the terms of the GNU Lesser General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.

 # Fabric-Generator-MCreator is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 # GNU Lesser General Public License for more details.
 #
 # You should have received a copy of the GNU Lesser General Public License
 # along with Fabric-Generator-MCreator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */
<#compress>
package ${package}.init;

public class ${JavaModName}Features {

	public static void load() {
	<#list features as feature>
		<#if feature.getModElement().getTypeString() == "block">
			register("${feature.getModElement().getRegistryName()}", new ${feature.getModElement().getName()}Feature(),
				${feature.getModElement().getName()}Feature.GENERATE_BIOMES, GenerationStep.Decoration.UNDERGROUND_ORES);
		<#elseif feature.getModElement().getTypeString() == "plant">
			register("${feature.getModElement().getRegistryName()}", new ${feature.getModElement().getName()}Feature(),
				${feature.getModElement().getName()}Feature.GENERATE_BIOMES, GenerationStep.Decoration.VEGETAL_DECORATION);
		<#elseif feature.getModElement().getTypeString() == "structure">
			register("${feature.getModElement().getRegistryName()}", new ${feature.getModElement().getName()}Feature(),
				${feature.getModElement().getName()}Feature.GENERATE_BIOMES, GenerationStep.Decoration.
				<#if feature.spawnLocation=="Air">RAW_GENERATION<#elseif feature.spawnLocation=="Underground">UNDERGROUND_STRUCTURES<#else>SURFACE_STRUCTURES</#if>);
		<#else>
		    <#if feature.hasGenerationConditions()>
                register("${feature.getModElement().getRegistryName()}", new ${feature.getModElement().getName()}Feature(),
                    ${feature.getModElement().getName()}Feature.GENERATE_BIOMES, GenerationStep.Decoration.${feature.generationStep});
			<#else>
                register("${feature.getModElement().getRegistryName()}", new NoOpFeature(NoneFeatureConfiguration.CODEC),
                    BiomeSelectors.all(), GenerationStep.Decoration.${feature.generationStep});
			</#if>
		</#if>
	</#list>
	}

	private static void register(String registryName, Feature feature, Predicate<BiomeSelectionContext> biomes, GenerationStep.Decoration genStep) {
		Registry.register(BuiltInRegistries.FEATURE, new ResourceLocation(${JavaModName}.MODID, registryName), feature);
	 	BiomeModifications.addFeature(biomes, genStep, ResourceKey.create(Registries.PLACED_FEATURE,
	 				new ResourceLocation(${JavaModName}.MODID, registryName)));
	}

}
</#compress>
<#-- @formatter:on -->
